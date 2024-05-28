# == Schema Information
#
# Table name: issues
#
#  id         :bigint           not null, primary key
#  link       :string
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :issue do
    name { "MyString" }
    link { "MyString" }
  end
end
