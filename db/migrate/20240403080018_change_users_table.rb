class ChangeUsersTable < ActiveRecord::Migration[7.0]
  def change
        add_column :users, :active_state, :boolean
        add_column :users, :is_manager, :boolean
  end
end
 