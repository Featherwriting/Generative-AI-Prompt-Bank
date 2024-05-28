class CreatePrompts < ActiveRecord::Migration[7.0]
  def change
    create_table :prompts do |t|
      t.belongs_to :category, index: true
      t.text :prompt_content
      t.integer :stat
      t.string :submitter_email
      t.integer :use_count

      t.timestamps
    end
  end
end
