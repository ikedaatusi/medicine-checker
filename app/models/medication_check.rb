class MedicationCheck < ApplicationRecord
    belongs_to :drug
    belongs_to :take_time

    # validates :check_time, uniqueness: { scope: [:drug_id, :take_time_id], message: "同じ服用時間に対して既にチェックが存在します。" }
    
     # 任意で、デフォルト値を設定するコールバックを追加できます
#   before_validation :set_default_check_time

#   private

#   def set_default_check_time
#     self.check_time ||= Date.today
#   end
end
