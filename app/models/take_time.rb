class TakeTime < ApplicationRecord
  belongs_to :drug
  
  enum take_time: {  free: 0, standard: 1, premium: 2 }

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "drug_id", "id", "take_time", "updated_at"]
  end
end
