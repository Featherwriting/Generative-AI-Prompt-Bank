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
require 'rails_helper'

RSpec.describe Example, type: :model do
  # Validation checks
  describe 'validations' do
    it { should validate_presence_of(:link) }
    it { should validate_presence_of(:prompt_id) }
  end

  # Associations check
  describe 'associations' do
    it { should belong_to(:prompt) }
  end

  describe 'methods' do
    describe 'create_example' do
      it 'creates an example' do
        # Invoke the create_example method and perform assertions
        FactoryBot.create(:prompt, id: 999, prompt_content: 'test')
        expect {Example.create_example('test link', 999)}.to change { Example.count }.by(1)
        
        # Retrieve the last created example
        created_example = Example.last

        # Perform assertions to verify the created example
        expect(created_example.link).to eq('test link')
        expect(created_example.prompt_id).to eq(999)
      end
    end

    describe 'update_example_by_manager' do
      # Define test data
      let!(:prompt) { create(:prompt, id: 999) } 
      let!(:example) { create(:example, prompt_id:999) }
      it 'updates example information' do
        # Invoke the update_example_by_manager method and perform assertions
        Example.update_example_by_manager(example.id, 'updated link', 999)

        example.reload

        # Perform assertions to verify the updated example
        expect(example.link).to eq('updated link')
        expect(example.prompt_id).to eq(999)
      end
    end
  end
end
