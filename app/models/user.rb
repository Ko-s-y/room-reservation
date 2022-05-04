class User < ApplicationRecord

  has_one_attached :avatar

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :full_name, presence: true, length: {maximum: 30}
  validates :email, presence: true, length: {maximum: 30}
  validates :introduction, presence: true, length: {maximum: 100}

end
