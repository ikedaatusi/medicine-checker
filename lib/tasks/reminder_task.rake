namespace :reminder_task do
    desc "メッセージを送信するタスク"
    task send_message: :environment do
      webhook = WebhookController.new
      message = {
        type: 'text',
        text: 'お薬のリマインダーです！今日の服用予定をチェックして、充実した一日を送りましょう！'
      }
      
      # すべてのLINEユーザーにメッセージを送信
      LineUserId.find_each do |user|
        webhook.client.push_message(user.uid, message)
      end
    end
  end