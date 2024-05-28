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
require 'rails_helper'

RSpec.describe Category, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:purpose) }
  end

  describe 'associations' do
    it { should have_many(:prompts) }
  end

  describe 'methods' do
    describe 'create_category' do
      it 'creates a category with provided information' do
        expect {
          Category.create_category('Test Category', 'Test Purpose')
        }.to change { Category.count }.by(1)

        created_category = Category.last

        expect(created_category.name).to eq('Test Category')
        expect(created_category.purpose).to eq('Test Purpose')
      end
    end

    describe 'update_category_by_manager' do
      let!(:category) { create(:category) }

      it 'updates a category with provided information' do
        Category.update_category_by_manager(category.id, 'Updated Category', 'Updated Purpose')

        category.reload

        expect(category.name).to eq('Updated Category')
        expect(category.purpose).to eq('Updated Purpose')
      end
    end

    describe 'find_category_by_purpose' do
      let!(:category1) { create(:category, purpose: 'Test Purpose') }
      let!(:category2) { create(:category, purpose: 'Another Purpose') }

      it 'finds categories by purpose' do
        found_categories = Category.find_category_by_purpose('Test')

        expect(found_categories).to include(category1)
        expect(found_categories).not_to include(category2)
      end
    end

    describe 'find_category_by_name' do
      let!(:category1) { create(:category, name: 'Test Category') }
      let!(:category2) { create(:category, name: 'Another Category') }

      it 'finds categories by name' do
        found_categories = Category.find_category_by_name('Test')

        expect(found_categories).to include(category1)
        expect(found_categories).not_to include(category2)
      end
    end
  end
end
