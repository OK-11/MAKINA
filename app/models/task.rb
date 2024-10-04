class Task < ApplicationRecord
  has_many :project_mission_tasks
  has_many :project_missions, through: :project_mission_tasks

  validates :name, presence: true
end