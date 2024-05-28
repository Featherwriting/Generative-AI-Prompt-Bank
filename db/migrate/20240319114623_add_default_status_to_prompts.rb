class AddDefaultStatusToPrompts < ActiveRecord::Migration[7.0]
  def change
    change_column_default :prompts, :use_count, from: nil, to: 0
  end
end
