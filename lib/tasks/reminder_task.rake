namespace :reminder_task do
    desc "メッセージを送信するタスク"
    task send_message: :environment do
      webhook = WebhookController.new
      message = {
        type: 'text',
        text: 'おめでとう！リマインダーメッセージ設定成功だよ！'
      }
      
      # すべてのLINEユーザーにメッセージを送信
      LineUserId.find_each do |user|
        webhook.client.push_message(user.uid, message)
      end
    end
  end