# == Schema Information
#
# Table name: categories
#
#  id         :bigint           not null, primary key
#  name       :string
#  purpose    :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :category do
    sequence(:name) { |n| "Category#{n}" }
    sequence(:purpose) { |n| "Purpose#{n}" }
  end
end
