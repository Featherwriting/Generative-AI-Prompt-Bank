# == Schema Information
#
# Table name: users
#
#  id                 :bigint           not null, primary key
#  account_type       :string
#  active_state       :boolean
#  current_sign_in_at :datetime
#  current_sign_in_ip :string
#  dn                 :string
#  email              :string           default(""), not null
#  givenname          :string
#  is_manager         :boolean
#  last_sign_in_at    :datetime
#  last_sign_in_ip    :string
#  mail               :string
#  ou                 :string
#  sign_in_count      :integer          default(0), not null
#  sn                 :string
#  uid                :string
#  username           :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
# Indexes
#
#  index_users_on_email     (email)
#  index_users_on_username  (username)
#
class User < ApplicationRecord
  include EpiCas::DeviseHelper
  def self.promote_admin(admin_email)
      admin = User.find_by(email: admin_email)
      if admin
        admin.update(active_state: true, account_type: "admin")
      else
        User.create(email: admin_email, active_state: true, account_type: "admin")
      end
  end


  def self.demote_admin(id)
      admin = User.find(id)
      admin.update(active_state: false, account_type: "user")
  end

  def self.varify_account_nil(email)
      SheffieldLdapLookup::LdapFinder.new(email).lookup.nil?
  end

  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
end
