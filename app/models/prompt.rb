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
class Prompt < ApplicationRecord
    belongs_to :category
    has_and_belongs_to_many :tags, dependent: :destroy
    has_and_belongs_to_many :issues, dependent: :destroy
    has_many :examples

    validates :prompt_content, presence: true #prompt_content not empty

    def self.create_prompts_by_user(prompt_content, stat, submitter_email)
        prompt = Prompt.new
        prompt.prompt_content = prompt_content
        prompt.stat = -1
        prompt.submitter_email = submitter_email
        category = Category.find_by(id: category_id)
        prompt.tags = tags
        prompt.save
    end

    def self.create_prompts_by_user(prompt_content,email_address,category_id,tags,issues,examples)
        #create a prompt with basic informations
        prompt = Prompt.find_or_create_by(prompt_content:prompt_content,stat:-1,submitter_email:email_address)

        #deal with category
        category = Category.find(Integer(category_id))
        category.prompts << prompt

        #deal with tags
        if(tags.nil? || tags.empty? || tags == [] || tags.strip() == "")
        
        else
            tag_array = tags.split(",").map(&:to_i)
            tag_array.each do |id|
                tag = Tag.find(id)
                prompt.tags << tag
            end
        end

        #deal with issues
        if(issues.nil? || issues.empty? || issues == [] || issues.strip() == "")
        
        else
            issue_array = issues.split(",").map(&:to_i)
            issue_array.each do |id|
                issue = Issue.find(id)
                prompt.issues << issue
            end
        end
        
        #check if the prompt create success
        if prompt.persisted?
        else
            puts(prompt.errors.full_messages)
        end

        #transfer exapmle links to strings

        if(issues.nil? || issues.empty? || issues == [] || issues.strip() == "")
        else
            begin
                example_array = JSON.parse(examples)
            rescue JSON::ParserError => e
                puts "wrong json: #{e.message}"
                example_array = []
            end
            #deal with examples
            example_array.each do |example|
                create_example = Example.create(link: example)
                prompt.examples << create_example
            end
        end
    end

    def self.update_prompts_by_user(id,prompt_content,category_id,tags,issues,examples,stat,use_count)
        #find the prompt
        prompt = Prompt.find(id)

        prompt.prompt_content = prompt_content
        prompt.use_count = use_count
        #deal with category
        if prompt.category_id.present?
            old_category = Category.find(prompt.category_id)
            if old_category.id != Integer(category_id)
                old_category.prompts.delete(prompt)
            end
        end
          
        new_category = Category.find(Integer(category_id))
        new_category.prompts << prompt
          

        #deal with tags
        prompt.tags.clear
        if tags.present?
            tag_array = tags.split(",").map(&:to_i)
            tag_array.each do |id|
                tag = Tag.find(id)
                prompt.tags << tag
            end
        end
        #deal with issues
        prompt.issues.clear
        if issues.present?
            issue_array = issues.split(",").map(&:to_i)
            issue_array.each do |id|
                issue = Issue.find(id)
                prompt.issues << issue
            end
        end
        #check if the prompt create success
        if prompt.persisted?
        else
            puts(prompt.errors.full_messages)
        end

        #transfer exapmle links to strings
        prompt.examples.clear
        if examples.present?
            begin
                example_array = JSON.parse(examples)
            rescue JSON::ParserError => e
                puts "wrong json: #{e.message}"
                example_array = []
            end
            #deal with examples
            example_array.each do |example|
                create_example = Example.create(link: example)
                prompt.examples << create_example
            end
        end
        if stat.present?
            prompt.stat = 1
        else
            prompt.stat = 0
        end
        prompt.save
    end








    #example prompt.update(stat:1)
    def update_prompt(attributes)
        self.update(attributes)
    end
    
    def delete
        self.destroy
    end

    def decrease_use_count(use_count)
        self.update(use_count:use_count)
    end

    def increase_use_count()
        num = self.use_count + 2000 
        self.update(use_count:num)
    end
    # def get_prompt_count()
    #     @prompts = Prompt.all
    #     return @prompts.count
    # end

end
