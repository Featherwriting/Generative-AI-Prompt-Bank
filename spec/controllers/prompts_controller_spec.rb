require 'rails_helper'
RSpec.describe  PromptsController, type: :controller do
    describe 'get #api' do
        it 'return all prompts' do
            prompts = create_list(:prompt,6)
            get :api
            expect(response).to have_http_status(:success)
            json_response = JSON.parse(response.body)
            expect(json_response.length).to eq(prompts.length)
        end
    end
    
    describe "#delete_prompt" do
        let(:invalid_id) { 999 }
        context "when deleting a prompt" do
            it "deletes the prompt if it exists" do
                prompt = create(:prompt)
                expect{delete :delete_prompt, params: { id: prompt.id }}.to change(Prompt, :count).by(-1)
                expect(response).to redirect_to("/home")
            end

            it "redirects back to home if prompt does not exist" do
                delete :delete_prompt, params: { id: invalid_id }
                expect{response}.not_to change(Prompt, :count)
                expect(response).to redirect_to("/home")
            end
        end
    end

    describe "#submit_prompt" do
        context "with valid prompt data" do
            it "creates a new prompt" do
                category = create(:category)
                allow_any_instance_of(SheffieldLdapLookup::LdapFinder).to receive(:lookup).and_return(true)
                post :submit_prompt, params:{prompt:{text:"hello",email:"jxu137@sheffield.ac.uk",category:category.id,example:" "}}
                expect(Prompt.last).to be_present
                expect(Prompt.last.category_id).to eq(category.id)
                expect(flash[:warning]).to be_nil
                expect(response).to redirect_to("/home")
            end
        end

        context "with invalid prompt data" do
            it "does not create a new prompt and shows warning feedback" do
                category = create(:category)
                allow_any_instance_of(SheffieldLdapLookup::LdapFinder).to receive(:lookup).and_return(false)
                post :submit_prompt, params:{prompt:{text:"",email:"test@sheffield.ac.uk",category:category.id,example:" "}}
                expect(flash[:warning]).to be_present 
                expect(response).to redirect_to("/home")
            end
        end
    end


    describe "#submit_prompt_visible" do
        context "with valid prompt data" do
            it "creates a new prompt" do
                category = create(:category)
                prompt = create(:prompt)
                post :submit_prompt_visible, params:{prompt:{id:prompt.id,text:"hello",email:"jxu137@sheffield.ac.uk",category:category.id,example:" ",stat:"1"}}
                expect(Prompt.last).to be_present
                expect(Prompt.last.category_id).to eq(category.id)
                expect(flash[:warning]).to be_nil
                expect(response).to redirect_to("/home")
            end
        end

        context "with invalid prompt data" do
            it "does not create a new prompt and shows warning feedback" do
                category = create(:category)
                prompt = create(:prompt)
                post :submit_prompt_visible, params:{prompt:{id:prompt.id,text:"",email:"test@sheffield.ac.uk",category:category.id,example:" ",stat:"1"}}
                expect(flash[:warning]).to be_present 
                expect(response).to redirect_to("/home")
            end
        end
                context "with invalid prompt data" do
            it "does not create a new prompt and shows warning feedback" do
                category = create(:category)
                prompt = create(:prompt)
                post :submit_prompt_visible, params:{prompt:{id:prompt.id,text:"",email:"test@sheffield.ac.uk",category:"-1",example:" ",stat:"1"}}
                expect(flash[:warning]).to be_present 
                expect(response).to redirect_to("/home")
            end
        end
    end

    describe "#approve_prompt" do
        context "with valid prompt data" do
            it "update prompt visiable" do
                category = create(:category)
                prompt = create(:prompt)
                post :approve_prompt, params:{prompt:{id:prompt.id,text:"hello",email:"jxu137@sheffield.ac.uk",category:category.id,example:" ",stat:"1"}}
                expect(Prompt.last).to be_present
                expect(Prompt.last.category_id).to eq(category.id)
                expect(flash[:warning]).to be_nil
                expect(response).to redirect_to("/home")
            end
        end

        context "with invalid prompt data" do
            it "does not update prompt visiable" do
                category = create(:category)
                prompt = create(:prompt)
                post :approve_prompt, params:{prompt:{id:prompt.id,text:"",email:"test@sheffield.ac.uk",category:category.id,example:" ",stat:"1"}}
                expect(flash[:warning]).to be_present 
                expect(response).to redirect_to("/home")
            end
        end

        context "with invalid prompt data" do
            it "does not update prompt visiable" do
                category = create(:category)
                prompt = create(:prompt)
                post :approve_prompt, params:{prompt:{id:prompt.id,text:"",email:"test@sheffield.ac.uk",category:"-1",example:" ",stat:"1"}}
                expect(flash[:warning]).to be_present 
                expect(response).to redirect_to("/home")
            end
        end
    end

    describe "#reject_prompt" do
        context "with valid prompt data" do
            it "creates a new prompt" do
                category = create(:category)
                prompt = create(:prompt)
                expect{post :reject_prompt, params:{prompt:{id:prompt.id,email:"jxu137@sheffield.ac.uk",reason:""}}}.to change(Prompt, :count).by(-1)
                expect(response).to redirect_to("/home")
            end
        end
    end

    describe "#increase_clicks" do
        context "with valid prompt data" do
            it "creates a new prompt" do
                prompt = create(:prompt,use_count:0)
                array_id = [prompt.id]
                get :increase_clicks,params:{id:array_id}
                prompt.reload
                expect(prompt.use_count).to eq(1)
                expect(response).to have_http_status(:success)
            end
        end
    end

    describe "#decrease_use_count" do
        context "with valid prompt data" do
            it "creates a new prompt" do
                prompt = create(:prompt,use_count:2000)
                get :decrease_use_count,params:{id:prompt.id}
                prompt.reload
                expect(prompt.use_count).to eq(0)
                expect(response).to have_http_status(:success)
            end
        end
    end

    describe "#increase_use_count" do
        context "with valid prompt data" do
            it "creates a new prompt" do
                prompt = create(:prompt,use_count:0)
                get :increase_use_count,params:{id:prompt.id}
                prompt.reload
                expect(prompt.use_count).to eq(2000)
                expect(response).to have_http_status(:success)
            end
        end
    end

    describe "#valid_prompt" do
        it "varify user email" do
            category = create(:category)
            allow_any_instance_of(SheffieldLdapLookup::LdapFinder).to receive(:lookup).and_return(nil)
            prompts_controller = PromptsController.new
            warningwords,validate_state= prompts_controller.valid_prompt("","",category.id)
            expect(validate_state).to eq(false)

        end
        it "varify category" do

            allow_any_instance_of(SheffieldLdapLookup::LdapFinder).to receive(:lookup).and_return(nil)
            prompts_controller = PromptsController.new
            warningwords,validate_state= prompts_controller.valid_prompt("","","-1")
            expect(validate_state).to eq(false)

        end
    end


end