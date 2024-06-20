class Memo < ApplicationRecord
    belongs_to :drug

    validates :body, presence: true, length: { maximum: 255 } # メモの内容のバリデーション
    validates :create_time, presence: true # 日付のバリデーション
    validates :drug_id, presence: true # ドラッグIDのバリデーション
end
