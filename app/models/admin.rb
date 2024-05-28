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
#no more used this modle
class Admin < ApplicationRecord
    
end

