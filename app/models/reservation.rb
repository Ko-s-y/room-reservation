class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :room

  validates :people_number, :start_date, :end_date, :total_price, presence: true

  validate :check_start
  validate :check_date

  def check_start
    return if start_date.blank?
    errors.add(:start_date, "は明日以降で選択してください") if start_date < Date.today
  end

  def check_date
    return if end_date.blank? || start_date.blank?
    errors.add(:end_date, "はチェックイン日時以降で選択してください") if end_date < start_date + 1
  end

end
