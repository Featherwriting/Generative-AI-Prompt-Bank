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
require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'methods' do
    describe 'promote_admin' do
      # Define test data
      let!(:user) { create(:user, email: 'test', account_type: 'user') }
      it 'promotes a user to admin' do
        # Invoke the promote_admin method and perform assertions
        User.promote_admin(user.email)

        user.reload

        # Perform assertions to verify the updated prompt
        expect(user.account_type).to eq('admin')
      end
    end

    describe 'demote_admin' do
      # Define test data
      let!(:user) { create(:user,account_type: 'admin') }
      it 'demotes admin to user' do
        # Invoke the demote_admin method and perform assertions
        User.demote_admin(user.id)

        user.reload

        # Perform assertions to verify the updated user
        expect(user.account_type).to eq('user')
      end
    end
  end
end
