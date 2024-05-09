class TakeTime < ApplicationRecord
  belongs_to :drug
  
  enum take_time: { free: 1, standard: 2, premium: 3 }
end
