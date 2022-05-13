class User < ApplicationRecord

  has_many :rooms
  has_many :reservations

  has_one_attached :avatar

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :full_name, presence: true, length: {maximum: 30}
  validates :email, presence: true, length: {maximum: 30}, uniqueness: true
  validates :introduction, length: {maximum: 50}

  # パスワードの字数制限は　　/config/initializers/devise.rb　に記述　　8..128に変更　

end
