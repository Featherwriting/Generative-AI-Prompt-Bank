# == Schema Information
#
# Table name: tags
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'rails_helper'

RSpec.describe Tag, type: :model do
  # Validation checks
  describe 'validations' do
    it { should validate_presence_of(:name) }
  end

  # Associations check
  describe 'associations' do
    it { should have_and_belong_to_many(:prompts) }
  end

  describe 'methods' do
    describe 'create_tag' do
      it 'creates a tag' do
        # Invoke the create_tag method and perform assertions
        expect {
          Tag.create_tag('test name')
        }.to change { Tag.count }.by(1)
        
        # Retrieve the last created tag
        created_tag = Tag.last

        # Perform assertions to verify the created tag
        expect(created_tag.name).to eq('test name')
      end
    end

    describe 'update_tag_by_manager' do
      # Define test data
      let!(:tag) { create(:tag) }

      it 'updates a tag' do
        # Invoke the update_tag_by_manager method and perform assertions
        Tag.update_tag_by_manager(tag.id, 'updated name')

        tag.reload

        # Perform assertions to verify the updated tag
        expect(tag.name).to eq('updated name')
      end
    end
  end
end
