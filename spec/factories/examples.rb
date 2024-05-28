# == Schema Information
#
# Table name: examples
#
#  id         :bigint           not null, primary key
#  link       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  prompt_id  :bigint
#
# Indexes
#
#  index_examples_on_prompt_id  (prompt_id)
#
FactoryBot.define do
  factory :example do
    link { "MyString" }
  end
end
