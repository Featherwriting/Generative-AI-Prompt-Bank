class CreateAdmins < ActiveRecord::Migration[7.0]
  def change
    create_table :admins do |t|
      t.string :admin_email
      t.boolean :active_state

      t.timestamps
    end
  end
end
