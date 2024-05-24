class TakeTime < ApplicationRecord
  has_many :medication_checks, dependent: :destroy
  belongs_to :drug

  accepts_nested_attributes_for :medication_checks, allow_destroy: true, reject_if: :all_blank
  
  enum take_time: {  朝食前: 0, 朝食後: 1, 昼食前: 2, 昼食後: 3, 夕食前: 4, 夕食後: 5, 寝る前: 6, 食間: 7, その他: 8}

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "drug_id", "id", "take_time", "updated_at"]
  end
end
