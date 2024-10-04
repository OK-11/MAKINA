class AddOrderToProjectMissions < ActiveRecord::Migration[6.1]
  def change
    add_column :project_missions, :order, :integer
  end
end
