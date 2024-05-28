require 'rails_helper'

RSpec.describe ContactFormController, type: :controller do

    describe "POST #create" do
        it "assigns the email and message" do
            post :create, params: { contact_form: { email: "test@example.com", message: "Hello!" } }
            expect(assigns(:email)).to eq("test@example.com")
            expect(assigns(:message)).to eq("Hello!")
        end
    end

    describe "Post #submit_contact" do
        it "send contact to server" do
            post :submit_contact, params: { contact_form: { email: "test@example.com", message: "Hello!" } }
            expect(flash[:success]).to eq("Your message has been sent successfully.")
            expect(response).to redirect_to("/contact")
        end
        it "send empty email address to server" do 
            post :submit_contact, params: { contact_form: { message: "Hello!" } }
            expect(flash[:warning]).to eq("The email address is not valid. ")
        end
        it "send empty contact address to server" do 
            post :submit_contact, params: { contact_form: { email: "test@example.com" } }
            expect(flash[:warning]).to eq("The message cannot be empty. ")
        end
        it "just click the submit button" do 
            post :submit_contact, params:{contact_form:{email:"",message:""}}
            expect(flash[:warning]).to eq("The email address is not valid. The message cannot be empty. ")
        end


    end

    describe "#valid_email?" do
        it "returns true for a valid email address" do
                instance = ContactFormController.new
                valid_emails = ["user@example.com", "john.doe@example.com", "test123@test.com"]
                valid_emails.each do |email|
                expect(instance.valid_email?(email)).to be_truthy
            end
        end

        it "returns false for an invalid email address" do
                instance = ContactFormController.new
                invalid_emails = ["invalid", "user@", "example.com", "test@"]

                invalid_emails.each do |email|
                expect(instance.valid_email?(email)).to be_falsey
            end
        end
    end


end