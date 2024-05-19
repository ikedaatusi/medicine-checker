class TakeTime < ApplicationRecord
  belongs_to :drug
  
  enum take_time: {  朝食前: 0, 朝食後: 1, 昼食前: 2, 昼食後: 3, 夕食前: 4, 夕食後: 5, 寝る前: 6, 食間: 7, その他: 8}

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "drug_id", "id", "take_time", "updated_at"]
  end
end
