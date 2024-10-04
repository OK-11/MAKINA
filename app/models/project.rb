class Project < ApplicationRecord
  belongs_to :user
  has_many :project_missions, dependent: :destroy
  has_many :missions, through: :project_missions

  validates :name, presence: true
  validates :user_id, presence: true
end
