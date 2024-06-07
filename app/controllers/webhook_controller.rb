class WebhookController < ApplicationController
  require 'line/bot' # LINE Bot API SDK を使用

  # CallbackアクションのCSRFトークン認証を無効化
  protect_from_forgery except: [:callback]

  def client
    @client ||= Line::Bot::Client.new do |config|
      config.channel_secret = ENV["LINE_CHANNEL_SECRET"]
      config.channel_token = ENV["LINE_CHANNEL_TOKEN"]
    end
  end

  def callback
    body = request.body.read
    signature = request.env['HTTP_X_LINE_SIGNATURE']

    unless client.validate_signature(body, signature)
      head :bad_request
      return
    end

    events = client.parse_events_from(body)

    events.each do |event|
      case event
      when Line::Bot::Event::Follow # 友達登録イベント
        userId = event['source']['userId']
        User.find_or_create_by(uid: userId)

        message = {
          type: 'text',
          text: "友達登録ありがとうございます！"
        }
        client.reply_message(event['replyToken'], message)

      when Line::Bot::Event::Unfollow # 友達削除イベント
        userId = event['source']['userId']
        # 必要に応じてユーザーの情報を削除する処理を追加できます
        # User.find_by(uid: userId)&.destroy

      when Line::Bot::Event::Message # メッセージイベント
        case event.type
        when Line::Bot::Event::MessageType::Text
          message = {
            type: 'text',
            text: event.message['text']
          }
          client.reply_message(event['replyToken'], message)
        end
      end
    end

    head :ok
  end
end
