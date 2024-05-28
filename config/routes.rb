Rails.application.routes.draw do

  mount EpiCas::Engine, at: "/"

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "pages#home"
  get "/home", to:"pages#home"
  get "/manage", to: "managers#manage"
  get "/privacy", to: "pages#privacy"
  get "/submit", to: "pages#submit"
  get "/test", to: "pages#test"
  get "/prompt_review", to: "managers#prompt_review"
  get "/tag", to: "pages#tag"
  get "/contact", to:"pages#contact"
  get "/admin_manager",to:"admins#admin_manager"
  get "/admin_history",to:"admins#admin_history"
  get "/manage_category", to:"managers#manage_category"
  get "/manage_tag", to:"managers#manage_tag"
  get "/manage_issue", to:"managers#manage_issue"
  get "/entrance", to: "pages#entrance"
  # Defines the root path for test("/")
  get "/test_prompt", to:"prompts#template"
  get "/test_user", to:"admins#User_test"
  get "/test", to:"pages#test"

  %w(404 422 500).each do |code|
    get code, to: "errors#show", code: code
  end

  
  resources :prompts do

    get :index, on: :collection
    get :api, on: :collection
    get :decrease_use_count, on: :collection
    get :increase_use_count, on: :collection
    post :delete_prompt, on: :collection
    post :submit_prompt, on: :collection
    post :submit_prompt_only_content, on: :collection
    post :submit_prompt_visible, on: :collection
    post :approve_prompt, on: :collection
    post :reject_prompt, on: :collection

    post :increase_clicks, on: :collection
    delete :delete_prompt, on: :member
  end

  resources :categories do
    get :index, on: :collection
    get :api, on: :collection
  
    post :update_category, on: :collection
    post :add_category, on: :collection
    put :update_category_name, on: :member
    put :update_category_purpose, on: :member
    put :update_category_button, on: :member
 
  end

  resources :tags do
    get :index, on: :collection
    get :api, on: :collection
    post :update_tag, on: :collection
    post :add_tag, on: :collection
    put :update_tag_button, on: :member

  end

  resources :issues do
    get :index, on: :collection
    get :api, on: :collection
    post :new_issue, on: :collection
    post :update_issue, on: :collection
    post :add_issue, on: :collection
    
  end


  resources :admins do
    post :promote_user, on: :collection
    post :demote_user, on: :collection
  end

  resources :examples
  resources :issues

  resources :pages do
    get :filter_prompt, on: :collection
    get :api, on: :collection
    get :return_prompts, on: :collection
    get :filter_prompt_only_tag, on: :collection
    get :manage_filter, on: :collection
    get :getDefaultPrompt, on: :collection
    get :getPendingPrompt, on: :collection
    get :getPopularPrompt, on: :collection
    get :pending_manage_filter, on: :collection
  end

  resources :contact_form do
    post :submit_contact, on: :collection
  end

  devise_for :users

end
