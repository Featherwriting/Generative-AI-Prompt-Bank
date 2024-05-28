# == Schema Information
#
# Table name: tags
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Tag < ApplicationRecord
    has_and_belongs_to_many :prompts, dependent: :destroy

    validates :name, presence: true

    def self.create_tag(name)
        tag = Tag.new
        tag.name = name
        tag.save
    end

    def self.update_tag(attributes)
        self.update(attributes)
    end

    def self.update_tag_by_manager(id,name)
        tag = Tag.find(id)
        tag.name = name
        tag.save
    end



end
