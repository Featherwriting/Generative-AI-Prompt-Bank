class ManagersController < ApplicationController
    before_action :authenticate_user!
    before_action :require_admin

    def manage_issue

    end

    def manage_tag
        
    end

    def manage_category
        
    end

    def prompt_review
        
    end

    def manage
        
    end

    def require_admin
        unless current_user && current_user.active_state?
          redirect_to '/home'
          flash[:warning] = "You are not authorized to access this page."
        end
    end
end
