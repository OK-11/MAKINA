class ProjectMissionTask < ApplicationRecord

  acts_as_list scope: :project_mission
  #project_mission単位でリストする

  belongs_to :project_mission
  belongs_to :task

  validates :project_mission_id, presence: true
  validates :project_mission_id, uniqueness: { scope: [:task_id]}
  validates :task_id, presence: true
  validates :status, numericality: { greater_than: 0 , less_than: 3}
  validates :role, presence: true, numericality: { greater_than: 0 , less_than: 4}
  #postionがnilの場合、acts_as_listによってpostion値がリスト内の最後の値になる
  
  

end
