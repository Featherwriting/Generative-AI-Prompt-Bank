require 'rails_helper'

RSpec.describe ManagersController, type: :controller do
  let(:user) { create(:user) }

  describe "#require_admin" do
    context "when user is not logged in" do
      it "redirects to home page with warning message" do
        get :manage_issue

        expect(response).to redirect_to('/users/sign_in')
      end
    end

    context "when user is logged in but not active" do
      before { sign_in user }

      it "redirects to home page with warning message" do
        get :manage_issue 

        expect(response).to redirect_to('/home')
        expect(flash[:warning]).to eq("You are not authorized to access this page.")
      end
    it "redirects to home page with warning message" do
        get :manage_tag 

        expect(response).to redirect_to('/home')
        expect(flash[:warning]).to eq("You are not authorized to access this page.")
      end
    end

    context "when user is logged in and active" do
        let(:admin_user) { create(:user, active_state: true,is_manager:true) }
        before { sign_in admin_user }

        it "allows access to the method" do
            get :manage_issue
            expect(response).to have_http_status(:success)
        end
        it "allows access to the method" do
            get :manage_tag
            expect(response).to have_http_status(:success)
        end
    end
  end
end
