class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :project_mission_task
  has_many :notices, dependent: :destroy
  has_many :users, through: :notices

  validates :body, presence: true
end
