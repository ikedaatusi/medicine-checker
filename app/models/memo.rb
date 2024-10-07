class Memo < ApplicationRecord
  belongs_to :drug

  validates :body, presence: true, length: { maximum: 255 } 
  validates :create_time, presence: true 
  validates :drug_id, presence: true 
end
