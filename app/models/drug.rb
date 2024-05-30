class Drug < ApplicationRecord
  belongs_to :user
  has_many :take_times, dependent: :destroy
  has_many :medication_checks, dependent: :destroy
  accepts_nested_attributes_for :take_times,allow_destroy: true, reject_if: :all_blank
  accepts_nested_attributes_for :medication_checks, allow_destroy: true, reject_if: :all_blank
  mount_uploader :image_url, ImageUploader
  validates :hospital_name, presence: true, length: { maximum: 10 }
  validates :drug_name, presence: true, length: { maximum: 10 }
  validates :number_of_tablets, presence: true, length: { maximum: 200 }

  

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "drug_name", "end_time", "hospital_name", "id", "image_url", "number_of_tablets", "start_time", "updated_at", "user_id"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["take_times", "user"]
  end
end
