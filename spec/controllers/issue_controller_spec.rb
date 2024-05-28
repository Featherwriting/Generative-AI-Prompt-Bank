# spec/models/issue_spec.rb

require 'rails_helper'

RSpec.describe IssuesController, type: :controller do

  describe '#index' do
    it 'assigns all issues to @issues' do
      issues = create_list(:issue, 3) 
      controller = IssuesController.new
      issue = controller.index 
      expect(issue.length).to eq(issues.length)
    end
  end

  describe '#api' do
    it 'returns JSON with all issues' do
      issues = create_list(:issue, 3)
      get :api

      expect(response).to have_http_status(:success)

      json_response = JSON.parse(response.body)
      expect(json_response.size).to eq(issues.size) 

      json_response.each_with_index do |issue, index|
        expect(issue['id']).to eq(issues[index].id) 
        expect(issue['name']).to eq(issues[index].name) 
        expect(issue['link']).to eq(issues[index].link)
      end
    end
  end

  describe 'POST #update_issue' do
    it 'updates the issue' do
      issue = Issue.create(name: '1', link: 'http://test.com')
      post :update_issue, params: { issue: { id: issue.id, name: "11", link: "http://test2.com", action:"edit"} }
      issue.reload
      expect(issue.name).to eq('11')
      expect(issue.link).to eq('http://test2.com')
      expect(response).to redirect_to('/home')
    end
  end

  describe 'POST #update_issue' do
    it 'delete the issue' do
      issue = Issue.create(name: '1', link: 'http://test.com')
      post :update_issue, params: { issue: { id: issue.id, name: "11", link: "http://test2.com", action:"delete"} }
      expect(Issue.exists?(issue.id)).to be_falsey
    end
  end

  describe 'POST #update_issue' do
    it 'upd11ates the issue' do
  
      issue = Issue.create(name: '1', link: 'http://test.com')
      
      post :update_issue, params: { issue: { id: issue.id, name: "", link: "" ,action:"edit"} }
      
      issue.reload
      expect(flash[:warning]).to eq("The issue cannot be empty. ")
      expect(response).to redirect_to('/home')
    end
  end

      
  



  describe '#add_issue' do
    it 'creates an issue when name and link are present' do
      post :add_issue, params: { issue: { name: 'Test Issue', link: 'http://example.com' } }
      expect(response).to redirect_to('/home')
      expect(Issue.last.name).to eq('Test Issue')
      expect(Issue.last.link).to eq('http://example.com')
    end

    it 'displays a warning when name is missing' do
      post :add_issue, params: { issue: { name: '', link: 'http://example.com' } }
      expect(response).to redirect_to('/home')
      expect(flash[:warning]).to eq("The issue cannot be empty. ")
      expect(Issue.count).to eq(0)
    end

    it 'displays a warning when link is missing' do
      post :add_issue, params: { issue: { name: 'Test Issue', link: '' } }
      expect(response).to redirect_to('/home')
      expect(flash[:warning]).to eq("The issue cannot be empty. ")
      expect(Issue.count).to eq(0)
    end

    it 'displays a warning when both name and link are missing' do
      post :add_issue, params: { issue: { name: '', link: '' } }
      expect(response).to redirect_to('/home')
      expect(flash[:warning]).to eq("The issue cannot be empty. ")
      expect(Issue.count).to eq(0)
    end
  end
end
