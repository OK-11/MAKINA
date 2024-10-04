class AddPositionToTableProjectMissions < ActiveRecord::Migration[6.1]
  def change
    add_column :project_missions, :position, :integer
  end
end
