class CreateExamples < ActiveRecord::Migration[7.0]
  def change
    create_table :examples do |t|
      t.belongs_to :prompt, index: true
      t.string :link

      t.timestamps
    end
  end
end
