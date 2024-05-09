class Drug < ApplicationRecord
  belongs_to :user
  has_many :take_times, dependent: :destroy
  accepts_nested_attributes_for :take_times, allow_destroy: true, reject_if: :all_blank
  mount_uploader :image_url, ImageUploader
  validates :hospital_name, presence: true, length: { maximum: 255 }
  validates :drug_name, presence: true, length: { maximum: 255 }
  validates :number_of_tablets, presence: true, length: { maximum: 200 }

  
end
