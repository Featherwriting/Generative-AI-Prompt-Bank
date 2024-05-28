
class PagesController < ApplicationController
  
  #filter_prompt - returns a list of prompts based on a provided search term,
  #tag list or category as json

  def filter_prompt
    form = params[:prompt]
    categoryid = params[:categoryid].to_i
    #check if the data get is the first time and assign prompt variables
    if form.nil? && (categoryid == -1 || categoryid.nil? || categoryid == 0)
      prompts = Prompt.where(stat: '1')
    elsif form.nil? #if the data has already been retrieved before, reset some variables
      visible_prompts = []
      category_prompts = [] 
      visible_prompts = Prompt.where(stat: '1')
      category_prompts = Category.find(categoryid).prompts
      non_empty_data = [visible_prompts,category_prompts]
      prompts = non_empty_data.inject(:&)
    else #otherwise make those variables empty
      prompts = []
      tag_prompts = []
      content_prompts = []
      category_prompts = []
      visible_prompts = []
      list_of_tags = []
      content = form[:content]
      tags = form[:tag]
      tag_array = tags.split(",").map(&:to_i)

      #if no category id supplied, get all prompts, else filter by category
      if categoryid == -1 || categoryid == 0 || categoryid.nil?
        category_prompts = Prompt.all
      else
        category_prompts = Category.find(categoryid).prompts
      end
      #filter prompts by visibility
      visible_prompts =  Prompt.where(stat: '1')
      #find prompts based on search term
      content_prompts = Prompt.where("LOWER(prompt_content) ILIKE ?", "%#{content.downcase}%")

      #find prompts by tag
      if tag_array.length == 0
        tag_prompts = Prompt.where(stat: '1')
      else
        tag_array.each do |id|
          list_of_tags<<Tag.find(id).prompts
        end
        tag_prompts = list_of_tags.reduce(:&)
        if tag_prompts.nil? || tag_prompts.empty?
          tag_prompts = []
        end
      end
      #if no filters return anything, return nothing!
      if tag_prompts.empty? && content_prompts.empty? && category_prompts.empty? 
        prompts = []
      else
        #else return the prompts
        non_empty_data = [tag_prompts, content_prompts, category_prompts,visible_prompts]
        prompts = non_empty_data.inject(:&)
      end
      
    end
    #return prompts as a json and render
    prompts = prompts.as_json(include: [:issues, :examples, :tags])
    render json: prompts

  end
  #filter_prompt_only_tag - filter prompts only based on the provided tags
  def filter_prompt_only_tag
    prompts = Prompt.all
    tagid = params[:tagid]
    prompts = Tag.find(tagid).prompts
    prompts = prompts.as_json(include: [:issues, :examples, :tags])
    render json: prompts
  end

  def api
    prompts = Prompt.all
    prompts = prompts.as_json(include: [:issues, :examples, :tags])
    render json: prompts
  end
  
  def manage_filter
    category = params[:category].to_s
    content = params[:content].to_s
    tag = params[:tag].to_s
    prompts = []
    if category == 'none'
      category_prompts = []
    else
      category_prompts = Category.find(category.to_i).prompts
    end
    if content == 'none'
      content_prompts = []
    else
      content_prompts = Prompt.where("LOWER(prompt_content) ILIKE ?", "%#{content.downcase}%")
    end
    if tag == 'none'
      tag_prompts = []
    else
      tag_prompts = Tag.find(tag).prompts
    end
    not_pendding_prompts = Prompt.where.not(stat: '-1').order(:id)
    non_empty_data = [tag_prompts, content_prompts, category_prompts,not_pendding_prompts].reject { |data| data.nil? || data.empty? }
    prompts = non_empty_data.inject(:&)
    if(prompts.nil? || prompts.empty? || prompts == [])
      getDefaultPrompt()
    else
      prompts = prompts.as_json(include: [:issues, :examples, :tags])
      render json: prompts
    end
  end

  def pending_manage_filter
    category = params[:category].to_s
    content = params[:content].to_s
    tag = params[:tag].to_s
    prompts = []
    if category == 'none'
      category_prompts = []
    else
      category_prompts = Category.find(category.to_i).prompts
    end
    if content == 'none'
      content_prompts = []
    else
      content_prompts = Prompt.where("LOWER(prompt_content) ILIKE ?", "%#{content.downcase}%")
    end
    if tag == 'none'
      tag_prompts = []
    else
      tag_prompts = Tag.find(tag).prompts
    end
    pendding_prompts = Prompt.where(stat: '-1').order(:id)
    non_empty_data = [tag_prompts, content_prompts, category_prompts,pendding_prompts].reject { |data| data.nil? || data.empty? }
    prompts = non_empty_data.inject(:&)
    if(prompts.nil? || prompts.empty? || prompts == [])
      prompts = getPendingPrompt()
    else
      prompts = prompts.as_json(include: [:issues, :examples, :tags])
      render json: prompts
    end
      
  end

  def getDefaultPrompt
    prompts = Prompt.where.not(stat: '-1').order(:id)
    prompts = prompts.as_json(include: [:issues, :examples, :tags])
    render json: prompts
  end

  def getPopularPrompt
    prompts = Prompt.where.not(stat: '-1').order(use_count: :desc)
    prompts = prompts.as_json(include: [:issues, :examples, :tags])
    render json: prompts
  end

  def getPendingPrompt
    prompts = Prompt.where(stat: '-1').order(:id)
    prompts = prompts.as_json(include: [:issues, :examples, :tags])
    render json: prompts
  end
end