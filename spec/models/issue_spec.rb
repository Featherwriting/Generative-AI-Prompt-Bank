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
require 'rails_helper'

RSpec.describe Issue, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:link) }
  end

  describe 'associations' do
    it { should have_and_belong_to_many(:prompts) }
  end

  describe 'methods' do
    describe 'create_issue' do
      it 'creates an issue with provided information' do
        expect {
          Issue.create_issue('http://example.com', 'Test Issue')
        }.to change { Issue.count }.by(1)

        created_issue = Issue.last

        expect(created_issue.link).to eq('http://example.com')
        expect(created_issue.name).to eq('Test Issue')
      end
    end

    describe 'update_issue_by_manager' do
      let!(:issue) { create(:issue) }

      it 'updates an issue with provided information' do
        Issue.update_issue_by_manager(issue.id, 'http://updated.com', 'Updated Issue')

        issue.reload

        expect(issue.link).to eq('http://updated.com')
        expect(issue.name).to eq('Updated Issue')
      end
    end
  end
end

