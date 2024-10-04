class RemoveOrderFromProjectMissions < ActiveRecord::Migration[6.1]
  def change
    remove_column :project_missions, :order, :integer
  end
end
