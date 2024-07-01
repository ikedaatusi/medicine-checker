class Drug < ApplicationRecord
  belongs_to :user
  has_many :take_times, dependent: :destroy
  has_many :medication_checks, dependent: :destroy
  has_many :memos, dependent: :destroy
  accepts_nested_attributes_for :take_times,allow_destroy: true, reject_if: :all_blank
  accepts_nested_attributes_for :medication_checks, allow_destroy: true, reject_if: :all_blank
  mount_uploader :image_url, ImageUploader
  validates :hospital_name, presence: true, length: { maximum: 10 }
  validates :drug_name, presence: true, length: { maximum: 10 }
  validates :number_of_tablets, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 200 }
  validate :end_date_within_limit
  validate :end_date_after_start_date
  validate :take_times_presence

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "drug_name", "end_time", "hospital_name", "id", "image_url", "number_of_tablets", "start_time", "updated_at", "user_id"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["take_times", "user"]
  end
  
  private

  def take_times_presence
    if take_times.reject(&:marked_for_destruction?).none? { |tt| tt.take_time.present? }
      errors.add(:base, "タイミングを追加してください")
    end
  end

  def end_date_within_limit
    if start_time.present? && end_time.present?
      duration = (end_time - start_time).to_i
      errors.add(:start_time, "期間は最長180日間まで!") if duration > 180
    end
  end

  def end_date_after_start_date
    errors.add(:end_time, "は開始日以降で！") if start_time.present? && end_time.present? && end_time < start_time
  end
end
