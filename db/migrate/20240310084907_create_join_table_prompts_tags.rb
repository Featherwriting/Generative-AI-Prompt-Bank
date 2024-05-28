class CreateJoinTablePromptsTags < ActiveRecord::Migration[7.0]
  def change
    create_join_table :prompts, :tags do |t|
      t.index [:prompt_id, :tag_id]
      t.index [:tag_id, :prompt_id]
    end
  end
end
