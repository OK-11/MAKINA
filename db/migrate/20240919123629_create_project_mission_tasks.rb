class CreateProjectMissionTasks < ActiveRecord::Migration[6.1]
  def change
    create_table :project_mission_tasks do |t|
      t.references :project_mission, null: false, foreign_key: true
      t.references :task, null: false, foreign_key: true
      t.integer :status, default: 1, null: false
      t.integer :role, null: false

      t.timestamps
    end
  end
end
