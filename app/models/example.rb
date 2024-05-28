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
class Example < ApplicationRecord
    belongs_to :prompt

    validates :link, presence: true
    validates :prompt_id, presence: true

    def self.create_example(link, prompt_id)
        example = Example.new
        example.link = link
        example.prompt_id = prompt_id
        example.save
    end

    def self.update_example_by_manager(id,link,prompt_id)
        example = Example.find(id)
        example.link = link
        example.prompt_id = prompt_id
        example.save
    end
end
