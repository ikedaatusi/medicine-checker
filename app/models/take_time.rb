class TakeTime < ApplicationRecord
  has_many :medication_checks, dependent: :destroy
  belongs_to :drug
  
  accepts_nested_attributes_for :medication_checks, allow_destroy: true, reject_if: :all_blank
  
  enum take_time: {  朝食前: 0, 朝食後: 1, 昼食前: 2, 昼食後: 3, 夕食前: 4, 夕食後: 5, 寝る前: 6, 食間: 7, その他: 8}

  validate :unique_take_time_per_drug

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "drug_id", "id", "take_time", "updated_at"]
  end

  private

  def unique_take_time_per_drug
    if TakeTime.where(drug_id: drug_id, take_time: take_time).where.not(id: id).exists?
      errors.add(:take_time, 'の値が重複しています。同じ薬に対して重複するタイミングを設定することはできません。')
    end
  end
end
