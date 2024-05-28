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
class Issue < ApplicationRecord
    has_and_belongs_to_many :prompts, dependent: :destroy


    validates :name, presence: true
    validates :link, presence: true

    def self.create_issue(link,name)
        issue = Issue.new
        issue.link = link
        issue.name = name
        issue.save
    end

    def self.update_issue(attributes)
        self.update(attributes)
    end

    def self.update_issue_by_manager(id,link,name)
        issue = Issue.find(id)
        issue.link = link
        issue.name = name
        issue.save
    end

    
end
