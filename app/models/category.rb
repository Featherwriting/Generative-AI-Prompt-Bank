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
class Category < ApplicationRecord
    has_many :prompts

    validates :name, presence: true
    validates :purpose, presence: true

    def self.create_category(name, purpose)
        category = Category.new
        category.name = name
        category.purpose = purpose
        category.save
    end



    def self.find_category_by_purpose(purpose)
        Category.where("purpose LIKE ?", "%#{sanitize_sql_like(purpose)}%")
    end

    def self.find_category_by_name(name)
        Category.where("name LIKE ?", "%#{sanitize_sql_like(name)}%")
    end

    def self.update_category(attributes)
        update(attributes)
    end

    def self.update_category_by_manager(id,name,purpose)
        category = Category.find(id)
        category.name = name
        category.purpose = purpose
        category.save
    end

  
end
