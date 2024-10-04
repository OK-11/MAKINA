class AddPositionToProjectMissionTasks < ActiveRecord::Migration[6.1]
  def change
    add_column :project_mission_tasks, :position, :integer
  end
end
