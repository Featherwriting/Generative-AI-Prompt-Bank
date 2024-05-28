# == Schema Information
#
# Table name: admins
#
#  id           :bigint           not null, primary key
#  active_state :boolean
#  admin_email  :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
FactoryBot.define do
  factory :admin do
    admin_email { "MyString" }
    active_state { false }
  end
end
