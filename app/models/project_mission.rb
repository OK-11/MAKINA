class ProjectMission < ApplicationRecord

  acts_as_list scope: :project

  belongs_to :project
  belongs_to :mission
  has_many :project_mission_tasks, dependent: :destroy
  has_many :tasks, through: :project_mission_tasks

  validates :project_id, presence: true
  validates :mission_id, presence: true
  validates :project_id, uniqueness: { scope: [:mission_id]}
  validates :status, numericality: { greater_than: 0 , less_than: 3}
  #postionがnilの場合、acts_as_listによってpostion値がリスト内の最後の値になる
  

  def missionGetTask(taskId , role)
    mission_task = self.project_mission_tasks.build(task_id: taskId , role: role)
    if mission_task.save
    else
      return mission_task.errors.full_messages
    end
  end

  def status_display
    if self.status == 1
      return "open"
    elsif self.status == 2
      return "close"
    end
  end


end


