class CreateIssues < ActiveRecord::Migration[7.0]
  def change
    create_table :issues do |t|
      t.string :name
      t.string :link

      t.timestamps
    end
  end
end
