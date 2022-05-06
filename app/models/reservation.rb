class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :room

  validates :people_number, :start_date, :end_date, presence: true

end
