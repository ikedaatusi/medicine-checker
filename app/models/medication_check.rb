class MedicationCheck < ApplicationRecord
  belongs_to :drug
  belongs_to :take_time
end
