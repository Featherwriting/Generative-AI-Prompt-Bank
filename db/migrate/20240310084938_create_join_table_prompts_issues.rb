class CreateJoinTablePromptsIssues < ActiveRecord::Migration[7.0]
  def change
    create_join_table :prompts, :issues do |t|
      t.index [:prompt_id, :issue_id]
      t.index [:issue_id, :prompt_id]
    end
  end
end
