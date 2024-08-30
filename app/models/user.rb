class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :articles
  has_many :comments, dependent: :destroy
  # Регулярное выражение для проверки формата email и домена
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.(com|ru)\z/i

  # Валидация уникальности и правильности формата email
  validates :email, presence: true, uniqueness: { case_sensitive: false },
            format: { with: VALID_EMAIL_REGEX, message: "должен быть действительным и оканчиваться на .com или .ru" }
end
