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
require 'rails_helper'

RSpec.describe Prompt, type: :model do

  describe 'validations' do
    it { should validate_presence_of(:prompt_content) }
  end

  describe 'associations' do
    it { should belong_to(:category) }
    it { should have_and_belong_to_many(:tags) }
    it { should have_and_belong_to_many(:issues) }
    it { should have_many(:examples) }
  end

  describe 'methods' do

    describe 'create_prompts_by_user' do
      # Define test data
      let(:category) { create(:category) }
      let(:tag1) { create(:tag) }
      let(:tag2) { create(:tag) }
      let(:issue1) { create(:issue) }
      let(:issue2) { create(:issue) }

      it 'creates a prompt with provided information' do
        # Stub the find method for Category, Tag, and Issue
        allow(Category).to receive(:find).with(category.id).and_return(category)
        allow(Tag).to receive(:find).with(any_args).and_return(tag1, tag2)
        allow(Issue).to receive(:find).with(any_args).and_return(issue1, issue2)

        # Invoke the create_prompts_by_user method and perform assertions
        expect {
          Prompt.create_prompts_by_user('Test prompt','test@example.com', category.id,"#{tag1.id},#{tag2.id}","#{issue1.id},#{issue2.id}",'["example1", "example2"]')
        }.to change { Prompt.count }.by(1)

        # Retrieve the last created prompt
        created_prompt = Prompt.last

        # Perform assertions to verify the created prompt
        expect(created_prompt.prompt_content).to eq('Test prompt')
        expect(created_prompt.submitter_email).to eq('test@example.com')
        expect(created_prompt.category).to eq(category)
        expect(created_prompt.tags).to contain_exactly(tag1, tag2)
        expect(created_prompt.issues).to contain_exactly(issue1, issue2)
        expect(created_prompt.examples.pluck(:link)).to eq(['example1', 'example2'])
      end
    end


    describe 'update_prompts_by_user' do
      # Define test data
      let!(:prompt) { create(:prompt) } 
      let(:category) { create(:category) }
      let(:tag1) { create(:tag) }
      let(:tag2) { create(:tag) }
      let(:issue1) { create(:issue) }
      let(:issue2) { create(:issue) }

      it 'updates a prompt with provided information' do
        # Stub the find method for Category, Tag, and Issue
        allow(Category).to receive(:find).and_return(category)
        allow(Tag).to receive(:find).and_return(tag1, tag2)
        allow(Issue).to receive(:find).and_return(issue1, issue2)

        # Invoke the update_prompts_by_user method and perform assertions
        expect {
          Prompt.update_prompts_by_user(prompt.id, 'Updated test prompt',
            category.id, "#{tag1.id},#{tag2.id}", "#{issue1.id},#{issue2.id}",
            '["example3", "example4"]', true, 99)
        }.not_to change { Prompt.count } # Ensure that no new prompt is created

        prompt.reload

        # Perform assertions to verify the updated prompt
        expect(prompt.prompt_content).to eq('Updated test prompt')
        expect(prompt.category).to eq(category)
        expect(prompt.tags).to contain_exactly(tag1, tag2)
        expect(prompt.issues).to contain_exactly(issue1, issue2)
        expect(prompt.examples.pluck(:link)).to eq(["example3", "example4"])
        expect(prompt.stat).to eq(1)
        expect(prompt.use_count).to eq(99)
      end
    end


    describe 'update_prompt' do
      # Define test data
      let(:prompt) { create(:prompt) }

      it 'updates a prompt with provided attributes' do
        new_prompt_content = 'New test prompt content'

        prompt.update_prompt(prompt_content: new_prompt_content)

        expect(prompt.reload.prompt_content).to eq(new_prompt_content)
      end
    end


    describe 'delete' do
      # Define test data
      let!(:prompt) { create(:prompt) }

      it 'deletes the prompt' do
        expect {
          prompt.delete
        }.to change { Prompt.count }.by(-1)
      end
    end

    describe 'decrease_use_count' do
      # Define test data
      let!(:prompt) { create(:prompt, use_count: 100) }

      it 'decreases the use count by specified amount' do
        prompt.decrease_use_count(50)

        expect(prompt.reload.use_count).to eq(50)
      end
    end

    describe 'increase_use_count' do
      # Define test data
      let!(:prompt) { create(:prompt, use_count: 100) }

      it 'increases the use count by 2000' do
        prompt.increase_use_count

        expect(prompt.reload.use_count).to eq(2100)
      end
    end
  end
end
