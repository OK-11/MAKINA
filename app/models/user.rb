class User < ApplicationRecord
  has_many :projects, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :project_mission_tasks, through: :comments
  has_many :notices, dependent: :destroy
  has_many :comments, through: :notices

  has_secure_password

  validates :name, presence: true
  validates :email, presence: true , uniqueness: true
  validates :password, length: {minimum: 6}
  #has_secure_passwordによって、
  #passwordの存在確認とpassword_confirmationと一致しているかのバリデーションが自動で追加されている
  validates :position, numericality: { greater_than: 0 , less_than: 3}
end









