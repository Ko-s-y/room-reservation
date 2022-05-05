class Room < ApplicationRecord

  belongs_to :user
  has_many :reservations

  has_one_attached :avatar

  validates :room_name, presence: true, length: {maximum: 30}#, uniqueness: { scope: :user }
  validates :description, presence: true, length: {maximum: 200}
  validates :price, presence: true, length: {maximum: 8}
  validates :address, presence: true, length: {maximum: 40}

end
