class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.string :password_digest, null: false
      t.boolean :admin, default: false, null: false
      t.integer :position, default: 1, null: false

      t.timestamps
    end
    
    add_index :users, :email, unique: true
  end
end
