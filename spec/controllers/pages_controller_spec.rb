require 'rails_helper'

RSpec.describe PagesController, type: :controller do

    describe "POST #filter_prompt" do
        context "when form and categoryid are not provided" do
            it "returns all prompts with stat '1'" do
                post :filter_prompt
                expect(response).to have_http_status(:success)
                json_response = JSON.parse(response.body)
                expect(json_response).to be_an_instance_of(Array)
                prompts = Prompt.where(stat: '1').as_json(include: [:issues, :examples, :tags])
                expect(json_response).to match_array(prompts)
            end
        end

        context "when form is not provided and categoryid is valid" do
            it "returns prompts filtered by categoryid with stat '1'" do
                category = create(:category)
                prompts_with_category = create_list(:prompt, 3, category: category, stat: '1')
                additional_category = create(:category)
                create_list(:prompt, 3,category:additional_category)

                post :filter_prompt, params: { categoryid: category.id }

                expect(response).to have_http_status(:success)
                json_response = JSON.parse(response.body)
                expect(json_response).to be_an_instance_of(Array)

                expected_prompts = prompts_with_category.as_json(include: [:issues, :examples, :tags])
                expect(json_response).to match_array(expected_prompts)
            end
        end

        context "when form is provided with content and tags" do
            it "returns prompts filtered by content and tags with stat '1'" do
                  tags = create_list(:tag, 4)
                  category = create(:category)
                  prompts_with_tags = create_list(:prompt, 4, tags: tags, stat: '1')

                  post :filter_prompt, params: { prompt: { content: "example", tag: tags.pluck(:id).join(","), categoryid: category.id } }

                  expect(response).to have_http_status(:success)
                  json_response = JSON.parse(response.body)
                  expect(json_response).to be_an_instance_of(Array)

                  expected_ids = prompts_with_tags.pluck(:id) 
                  actual_ids = json_response.map { |prompt| prompt['id'] }
                  expect(actual_ids).to match_array(expected_ids)
            end
        end

        context "when form is provided with content and tags" do
            it "returns prompts filtered by content, category and tags with stat '1'" do
                  category = create(:category)
                  prompts_with_categories = create_list(:prompt, 4, stat: '1',category_id:category.id)

                  post :filter_prompt, params: { prompt: { content: "example", tag:""},categoryid: category.id }

                  expect(response).to have_http_status(:success)
                  json_response = JSON.parse(response.body)
                  expect(json_response).to be_an_instance_of(Array)

                  expected_ids = prompts_with_categories.pluck(:id) 
                  actual_ids = json_response.map { |prompt| prompt['id'] }
                  expect(actual_ids).to match_array(expected_ids)
            end

            it "returns prompts filtered by content, category and tags with stat '1'" do
              category = create(:category, name: 'Category A')
              tag1 = create(:tag, name: 'Tag 1')
              tag2 = create(:tag, name: 'Tag 2')
              tag3 = create(:tag, name: 'Tag 3')
              tag4 = create(:tag, name: 'Tag 4')
              prompt1 = create(:prompt, prompt_content: 'This is an example prompt 1',category: category, tags: [tag1], stat: '1')
              prompt2 = create(:prompt, prompt_content: 'This is another example prompt', category: category, tags: [tag3], stat: '1')
              prompt3 = create(:prompt, prompt_content: 'This is yet another prompt', tags: [tag2], category: category,stat: '1')
              prompt4 = create(:prompt, prompt_content: 'Inactive prompt', category: category,stat: '-1')

              prompts_with_categories = create_list(:prompt, 4, stat: '1',category_id:category.id)
              post :filter_prompt, params: { prompt: { content: "example", tag:"#{tag1.id},#{tag2.id},#{tag3.id},#{tag4.id}"},categoryid: category.id }

              expect(response).to have_http_status(:success)
              json_response = JSON.parse(response.body)
              expect(json_response).to be_an_instance_of(Array)
              actual_ids = json_response.map { |prompt| prompt['id'] }
              expect(actual_ids).to be_empty
            end

            it "returns prompts filyer by everything but empty" do
              category = create(:category, name: 'Category A')
              categoryB = create(:category, name: 'Category B')
              tag1 = create(:tag, name: 'Tag 1')
              tag2 = create(:tag, name: 'Tag 2')
              tag3 = create(:tag, name: 'Tag 3')
              tag4 = create(:tag, name: 'Tag 4')
              prompt1 = create(:prompt, prompt_content: 'This is an example prompt 1',category: category, tags: [tag1], stat: '1')
              prompt2 = create(:prompt, prompt_content: 'This is another example prompt', category: category, tags: [tag3], stat: '1')
              prompt3 = create(:prompt, prompt_content: 'This is yet another prompt', tags: [tag2], category: category,stat: '1')
              prompt4 = create(:prompt, prompt_content: 'Inactive prompt', category: category,stat: '-1')

              prompts_with_categories = create_list(:prompt, 4, stat: '1',category_id:category.id)
              prompts_with_categories = create_list(:prompt, 4, stat: '1',category_id:category.id)
              post :filter_prompt, params: { prompt: { content: "nothing", tag:"#{tag1.id},#{tag2.id},#{tag3.id},#{tag4.id}"},categoryid: categoryB.id }
              expect(response).to have_http_status(:success)
              json_response = JSON.parse(response.body)
              expect(json_response).to be_an_instance_of(Array)
              actual_ids = json_response.map { |prompt| prompt['id'] }
              expect(actual_ids).to be_empty
            end
        end
      end

    describe "GET #filter_prompt_only_tag" do
      it "returns prompts filtered by a specific tag" do
        tag = create(:tag)
        get :filter_prompt_only_tag, params: { tagid: tag.id }
        expect(response).to have_http_status(:success)
        json_response = JSON.parse(response.body)
        expect(json_response).to be_an_instance_of(Array)
        json_response.each do |prompt|
          expect(prompt["issues"]).to be_present
          expect(prompt["examples"]).to be_present
          expect(prompt["tags"]).to be_present
        end
      end

    describe "GET #api" do
      it "return all stuff in prompts" do
        prompts = Prompt.all
        get :api
        expect(response).to have_http_status(:success)
        json_response = JSON.parse(response.body)
        expect(json_response).to be_an_instance_of(Array)
        expect(json_response).to match_array(prompts)
      end
    end
    
    describe "POST #manage_filter" do
      it "returns prompts filtered by category, content, and tag" do
        category = create(:category, name: 'Category A')
        tag1 = create(:tag, name: 'Tag 1')
        tag2 = create(:tag, name: 'Tag 2')
        prompt1 = create(:prompt, prompt_content: 'This is an example prompt 1', tags: [tag1], stat: '1')
        prompt2 = create(:prompt, prompt_content: 'This is another example prompt', category: category, stat: '1')
        prompt3 = create(:prompt, prompt_content: 'This is yet another prompt', tags: [tag2], stat: '1')
        prompt4 = create(:prompt, prompt_content: 'Inactive prompt', stat: '-1')

        post :manage_filter, params: { category: "none", content: 'example', tag: "#{tag1.id}" }
        expect(response).to have_http_status(:success)
        json_response = JSON.parse(response.body)
        expect(json_response.map { |prompt| prompt['id'] }).to match_array(prompt1.id )
      end


      it "returns prompts filtered by content" do
        category = create(:category, name: 'Category A')
        tag1 = create(:tag, name: 'Tag 1')
        tag2 = create(:tag, name: 'Tag 2')
        prompt1 = create(:prompt, prompt_content: 'This is an example prompt 1', tags: [tag1], stat: '1')
        prompt2 = create(:prompt, prompt_content: 'This is another example prompt', category: category, stat: '1')
        prompt3 = create(:prompt, prompt_content: 'This is yet another prompt', tags: [tag2], stat: '1')
        prompt4 = create(:prompt, prompt_content: 'Inactive prompt', stat: '-1')

        post :manage_filter, params: { category: "none", content: 'example', tag: "none" }
        expect(response).to have_http_status(:success)
        json_response = JSON.parse(response.body)
        expect(json_response.map { |prompt| prompt['id'] }).to match_array([prompt1.id,prompt2.id] )
      end

      it "returns prompts filtered by tag" do
        category1 = create(:category, name: 'Category A')
        category2 = create(:category, name: 'Category B')
        tag1 = create(:tag, name: 'Tag 1')
        tag2 = create(:tag, name: 'Tag 2')
        prompt1 = create(:prompt, prompt_content: 'This is an example prompt 1', tags: [tag1],category: category2, stat: '1')
        prompt2 = create(:prompt, prompt_content: 'This is another example prompt', category: category1, stat: '1')
        prompt3 = create(:prompt, prompt_content: 'This is yet another prompt', tags: [tag2],category: category1, stat: '1')
        prompt4 = create(:prompt, prompt_content: 'Inactive prompt', stat: '-1')

        post :manage_filter, params: { category: "none", content: 'none', tag: tag2.id }
        expect(response).to have_http_status(:success)
        json_response = JSON.parse(response.body)
        expect(json_response.map { |prompt| prompt['id'] }).to match_array([prompt3.id] )
      end

      it "returns prompts filtered by category" do
        category1 = create(:category, name: 'Category A')
        category2 = create(:category, name: 'Category B')
        tag1 = create(:tag, name: 'Tag 1')
        tag2 = create(:tag, name: 'Tag 2')
        prompt1 = create(:prompt, prompt_content: 'This is an example prompt 1', tags: [tag1],category: category2, stat: '1')
        prompt2 = create(:prompt, prompt_content: 'This is another example prompt', category: category1, stat: '1')
        prompt3 = create(:prompt, prompt_content: 'This is yet another prompt', tags: [tag2],category: category1, stat: '1')
        prompt4 = create(:prompt, prompt_content: 'Inactive prompt', stat: '-1')
        post :manage_filter, params: { category: category1.id, content: 'none', tag: "none" }
        expect(response).to have_http_status(:success)
        json_response = JSON.parse(response.body)
        expect(json_response.map { |prompt| prompt['id'] }).to match_array([prompt2.id,prompt3.id] )
      end

      it "returns prompts filtered by category, content, tag with no fit" do
        category1 = create(:category, name: 'Category A')
        category2 = create(:category, name: 'Category B')
        tag1 = create(:tag, name: 'Tag 1')
        tag2 = create(:tag, name: 'Tag 2')
        prompt1 = create(:prompt, prompt_content: 'This is an example prompt 1', tags: [tag1],category: category2, stat: '1')
        prompt2 = create(:prompt, prompt_content: 'This is another example prompt', category: category1, stat: '1')
        prompt3 = create(:prompt, prompt_content: 'This is yet another prompt', tags: [tag2],category: category1, stat: '1')
        prompt4 = create(:prompt, prompt_content: 'Inactive prompt', stat: '-1')
        post :manage_filter, params: { category: category2.id, content: 'are you', tag: tag2.id }
        expect(response).to have_http_status(:success)
        json_response = JSON.parse(response.body)
        expect(json_response.map { |prompt| prompt['id'] }).to match_array([prompt1.id,prompt2.id,prompt3.id])
      end
    end

    describe "POST #pending_manage_filter" do
      it "returns prompts filtered by category, content, and tag" do
        category = create(:category, name: 'Category A')
        tag1 = create(:tag, name: 'Tag 1')
        tag2 = create(:tag, name: 'Tag 2')
        prompt1 = create(:prompt, prompt_content: 'This is an example prompt 1', tags: [tag1], stat: '-1')
        prompt2 = create(:prompt, prompt_content: 'This is another example prompt', category: category, stat: '-1')
        prompt3 = create(:prompt, prompt_content: 'This is yet another prompt', tags: [tag2], stat: '-1')
        prompt4 = create(:prompt, prompt_content: 'Inactive prompt', stat: '-1')

        post :pending_manage_filter, params: { category: "none", content: 'example', tag: "#{tag1.id}" }
        expect(response).to have_http_status(:success)
        json_response = JSON.parse(response.body)
        expect(json_response.map { |prompt| prompt['id'] }).to match_array(prompt1.id )
      end


      it "returns prompts filtered by content" do
        category = create(:category, name: 'Category A')
        tag1 = create(:tag, name: 'Tag 1')
        tag2 = create(:tag, name: 'Tag 2')
        prompt1 = create(:prompt, prompt_content: 'This is an example prompt 1', tags: [tag1], stat: '-1')
        prompt2 = create(:prompt, prompt_content: 'This is another example prompt', category: category, stat: '-1')
        prompt3 = create(:prompt, prompt_content: 'This is yet another prompt', tags: [tag2], stat: '-1')
        prompt4 = create(:prompt, prompt_content: 'Inactive prompt', stat: '-1')

        post :pending_manage_filter, params: { category: "none", content: 'example', tag: "none" }
        expect(response).to have_http_status(:success)
        json_response = JSON.parse(response.body)
        expect(json_response.map { |prompt| prompt['id'] }).to match_array([prompt1.id,prompt2.id] )
      end

      it "returns prompts filtered by tag" do
        category1 = create(:category, name: 'Category A')
        category2 = create(:category, name: 'Category B')
        tag1 = create(:tag, name: 'Tag 1')
        tag2 = create(:tag, name: 'Tag 2')
        prompt1 = create(:prompt, prompt_content: 'This is an example prompt 1', tags: [tag1],category: category2, stat: '-1')
        prompt2 = create(:prompt, prompt_content: 'This is another example prompt', category: category1, stat: '-1')
        prompt3 = create(:prompt, prompt_content: 'This is yet another prompt', tags: [tag2],category: category1, stat: '-1')
        prompt4 = create(:prompt, prompt_content: 'Inactive prompt', stat: '-1')

        post :pending_manage_filter, params: { category: "none", content: 'none', tag: tag2.id }
        expect(response).to have_http_status(:success)
        json_response = JSON.parse(response.body)
        expect(json_response.map { |prompt| prompt['id'] }).to match_array([prompt3.id] )
      end

      it "returns prompts filtered by category" do
        category1 = create(:category, name: 'Category A')
        category2 = create(:category, name: 'Category B')
        tag1 = create(:tag, name: 'Tag 1')
        tag2 = create(:tag, name: 'Tag 2')
        prompt1 = create(:prompt, prompt_content: 'This is an example prompt 1', tags: [tag1],category: category2, stat: '-1')
        prompt2 = create(:prompt, prompt_content: 'This is another example prompt', category: category1, stat: '-1')
        prompt3 = create(:prompt, prompt_content: 'This is yet another prompt', tags: [tag2],category: category1, stat: '-1')
        prompt4 = create(:prompt, prompt_content: 'Inactive prompt', stat: '-1')
        post :pending_manage_filter, params: { category: category1.id, content: 'none', tag: "none" }
        expect(response).to have_http_status(:success)
        json_response = JSON.parse(response.body)
        expect(json_response.map { |prompt| prompt['id'] }).to match_array([prompt2.id,prompt3.id] )
      end

      it "returns prompts filtered by category, content, tag with no fit" do
        category1 = create(:category, name: 'Category A')
        category2 = create(:category, name: 'Category B')
        tag1 = create(:tag, name: 'Tag 1')
        tag2 = create(:tag, name: 'Tag 2')
        prompt1 = create(:prompt, prompt_content: 'This is an example prompt 1', tags: [tag1],category: category2, stat: '-1')
        prompt2 = create(:prompt, prompt_content: 'This is another example prompt', category: category1, stat: '-1')
        prompt3 = create(:prompt, prompt_content: 'This is yet another prompt', tags: [tag2],category: category1, stat: '-1')
        prompt4 = create(:prompt, prompt_content: 'Inactive prompt', stat: '-1')
        post :pending_manage_filter, params: { category: category2.id, content: 'are you', tag: tag2.id }
        expect(response).to have_http_status(:success)
        json_response = JSON.parse(response.body)
        expect(json_response.map { |prompt| prompt['id'] }).to match_array([prompt1.id,prompt2.id,prompt3.id,prompt4.id])
      end
    end

    describe "get #getPopularPrompt" do
      it "return all things with stats 1 with popular order" do
        category1 = create(:category, name: 'Category A')
        category2 = create(:category, name: 'Category B')
        tag1 = create(:tag, name: 'Tag 1')
        tag2 = create(:tag, name: 'Tag 2')
        prompt1 = create(:prompt, prompt_content: 'This is an example prompt 1', tags: [tag1],category: category2, stat: '1',use_count:3)
        prompt2 = create(:prompt, prompt_content: 'This is another example prompt', category: category1, stat: '1',use_count:1)
        prompt3 = create(:prompt, prompt_content: 'This is yet another prompt', tags: [tag2],category: category1, stat: '1',use_count:5)
        prompt4 = create(:prompt, prompt_content: 'Inactive prompt', stat: '-1')
        get :getPopularPrompt,params:{}
        expect(response).to have_http_status(:success)
        json_response = JSON.parse(response.body)
        expect(json_response.map { |prompt| prompt['id'] }).to match_array([prompt3.id,prompt1.id,prompt2.id])
      end
  end

  end
end
