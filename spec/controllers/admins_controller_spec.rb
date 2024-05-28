require 'rails_helper'

RSpec.describe AdminsController, type: :controller do
  describe 'POST #promote_user' do
    context 'with valid email' do
      it 'promotes user to admin' do
        # Assuming you use FactoryBot or some other factory to create users
        user = User.create(email: 'jxu137@sheffield.ac.uk')#在User的表当中，创建一个新的元素，
        admin_user = User.create(email:'hello@.sheffield.ac.uk',active_state: true, is_manager:true)#这是最高权限的user
        sign_in admin_user #make current user
        allow_any_instance_of(SheffieldLdapLookup::LdapFinder).to receive(:lookup).and_return({ some: 'data' })#外部的方法找不到，假装他行
        post :promote_user, params: { email: user.email }#post是路由，params
        #params:{params:{text:sisisi}}
        expect(user.reload.active_state).to eq(true)
        expect(response).to redirect_to('/home')
      end
    end

    context 'with invalid email' do
      it 'does not promote user and sets warning flash' do
        user = User.create(email: 'test@example.com')
        post :promote_user, params: { email: user.email }
        expect(user.reload.active_state).to eq(nil)
        expect(response).to redirect_to('/users/sign_in')
      end
    end
    
  

  describe "demote_user" do
    it "should demote user" do
      # 创建一个管理员用户
      user = User.create(email: 'hello@sheffield.ac.uk', active_state: true) # 这是最高权限的用户
      admin_user = User.create(email:'hello@.sheffield.ac.uk',active_state: true, is_manager:true)#这是最高权限的user
      sign_in admin_user #make current user
      allow_any_instance_of(SheffieldLdapLookup::LdapFinder).to receive(:lookup).and_return({ some: 'data' })#外部的方法找不到，假装他行
      # 发送降级请求
      post :demote_user, params: { id: user.id }
      
      # 断言用户的状态被降级为非激活
      expect(user.reload.active_state).to eq(false)
      expect(response).to redirect_to('/home')

    end
  end

  describe '#require_manager' do
  context 'when user is an active manager' do
    it 'does not set warning flash' do
      manager_user = double('User', is_manager?: true)
      allow(controller).to receive(:current_user).and_return(manager_user)

      controller.send(:require_manager)

      expect(flash[:warning]).to be_nil
    end
  end

  context 'when user is not an active manager' do
    it 'sets warning flash and redirects to home page' do
      non_manager_user = double('User', is_manager?: false)
      allow(controller).to receive(:current_user).and_return(non_manager_user)

      response = double('response')
      allow(controller).to receive(:redirect_to) { response }

      controller.send(:require_manager)

      expect(flash[:warning]).to eq("You are not authorized to access this page.")
      expect(controller).to have_received(:redirect_to).with('/home')
    end
  end
end

  describe '#require_admin' do
    context 'when user is an active admin' do
      it 'does not set warning flash' do
        admin_user = double('User', active_state?: true)
        allow(controller).to receive(:current_user).and_return(admin_user)

        controller.send(:require_admin)

        expect(flash[:warning]).to be_nil
      end
    end

    context 'when user is not an active admin' do
      it 'sets warning flash and redirects to home page' do
        non_admin_user = double('User', active_state?: false)
        allow(controller).to receive(:current_user).and_return(non_admin_user)

        response = double('response')
        allow(controller).to receive(:redirect_to) { response }
        controller.send(:require_admin)

        expect(flash[:warning]).to eq("You are not authorized to access this page.")
        expect(controller).to have_received(:redirect_to).with('/home')
      end

      #pending cant deal with epi method
      # it "set warning flash" do
      #   admin_user = create(:user, active_state: true, is_manager: true)
      #   sign_in admin_user
      #   allow_any_instance_of(SheffieldLdapLookup::LdapFinder).to receive(:lookup).and_return(true)
      #   no_valid_user = create(:user,email:"123@shef.ac.uk")
      #   post :promote_user, params:{email:"jxu137@sheffield.ac.uk"}
      #   expect(flash[:warning]).to eq("You are not authorized to access this page.")
      #   expect(response).to redirect_to("/home")
      # end

    end
  end

 end
end

