class CreateProjectMissions < ActiveRecord::Migration[6.1]
  def change
    create_table :project_missions do |t|
      t.references :project, null: false, foreign_key: true
      t.references :mission, null: false, foreign_key: true
      t.integer :status, default: 1, null: false

      t.timestamps
    end
  end
end
