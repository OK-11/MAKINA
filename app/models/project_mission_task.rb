class ProjectMissionTask < ApplicationRecord

  acts_as_list scope: :project_mission
  #project_mission単位でリストする

  belongs_to :project_mission
  belongs_to :task

  has_many :comments, dependent: :destroy
  has_many :users, through: :comments

  validates :project_mission_id, presence: true
  validates :project_mission_id, uniqueness: { scope: [:task_id]}
  validates :task_id, presence: true
  validates :status, numericality: { greater_than: 0 , less_than: 3}
  validates :role, presence: true, numericality: { greater_than: 0 , less_than: 4}
  #postionがnilの場合、acts_as_listによってpostion値がリスト内の最後の値になる
  
  def role_display
    if self.role == 1
      return "クライアント"
    elsif self.role == 2
      return "ワーカー"
    elsif self.role == 3
      return "管理者"
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
