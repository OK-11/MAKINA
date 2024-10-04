class Mission < ApplicationRecord
  has_many :project_missions
  has_many :projects, through: :project_missions

  validates :name, presence: true
  
end
