require 'rails_helper'

RSpec.describe TagsController, type: :controller do
  
  describe '#index' do
  it 'assigns all tags to @tags' do
   tags = create_list(:tag, 3) 
   controller = TagsController.new
   tag = controller.index 
   expect(tag.length).to eq(tags.length)
  end
 end


  describe '#api' do
    it 'returns JSON with all tags' do
      tags = create_list(:tag, 3) 

      get :api

      expect(response).to have_http_status(:success)

      json_response = JSON.parse(response.body)
      expect(json_response.size).to eq(tags.size) 

      json_response.each_with_index do |tag, index|
        expect(tag['id']).to eq(tags[index].id) 
        expect(tag['name']).to eq(tags[index].name) 
        
      end
    end
  end


    describe 'POST #update_tag' do
      it 'updates the tag' do
    
        tag = Tag.create(name: '1')
        
        post :update_tag, params: { tag: { id: tag.id, name: "11",action:"edit"} }
        
        tag.reload
        
        expect(tag.name).to eq('11')
        
        expect(response).to redirect_to('/home')
      end
    end

    describe 'POST #update_tag' do
      it 'upd11ates the tag' do
    
        tag = Tag.create(name: '1')
        
        post :update_tag, params: { tag: { id: tag.id, name: "",action:"edit"} }
        
        tag.reload
        expect(flash[:warning]).to eq("The tag cannot be empty. ")
        expect(response).to redirect_to('/home')
      end
    end

    describe 'POST #update_tag' do
      it 'delete the tag' do
        tag = Tag.create(name: '1')
        post :update_tag, params: { tag: { id: tag.id, name: "",action:"delete"} }
        expect(Tag.exists?(tag.id)).to be_falsey
      end
    end
    
  describe '#add_tag' do
    it 'creates an tag when name and link are present' do
      post :add_tag, params: { tag: { name: 'Test tag'} }
      expect(response).to redirect_to('/home')
      expect(Tag.last.name).to eq('Test tag')
    
    end

    it 'displays a warning when name is missing' do
      post :add_tag, params: { tag: { name: ''} }
      expect(response).to redirect_to('/home')
      expect(flash[:warning]).to eq("The tag cannot be empty. ")
      expect(Issue.count).to eq(0)
    end
  end
end
