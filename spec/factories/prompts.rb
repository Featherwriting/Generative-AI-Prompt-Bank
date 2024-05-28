# == Schema Information
#
# Table name: prompts
#
#  id              :bigint           not null, primary key
#  prompt_content  :text
#  stat            :integer
#  submitter_email :string
#  use_count       :integer          default(0)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  category_id     :bigint
#
# Indexes
#
#  index_prompts_on_category_id  (category_id)
#
FactoryBot.define do
  factory :prompt do
    sequence(:prompt_content) { |n| "Prompt Content example #{n}" }
    stat { '1' } 
    association :category 
    after(:create) do |prompt|
      create_list(:tag, 3, prompts: [prompt]) 
    end
  end
end
