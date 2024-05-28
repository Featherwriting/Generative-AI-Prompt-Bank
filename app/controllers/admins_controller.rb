class AdminsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_manager

  #promote_user() - Firstly checks the user's email, then if it is a UoS email, 
  # will promote it to admin, else denies it.
  def promote_user()
    email_address = params[:email]
    email_address = email_address.downcase if email_address.present?
    if User.varify_account_nil(email_address)
      flash[:warning] = "The email address is not valid or is not a sheffield university email address"
    else
      User.promote_admin(email_address)
    end

    redirect_back(fallback_location: '/home')
  end

  #demote_user() - Takes an admin ID, and reduces their privlege to that of a user
  def demote_user()
    id = params[:id]
    User.demote_admin(id)
    redirect_back(fallback_location: '/home')
  end

  #require_manager() - If a user attempts to access a page that is restricted to managers, forbids 
  #them from accessing the page and redirects to home
  def require_manager
    unless current_user && current_user.is_manager?
      flash[:warning] = "You are not authorized to access this page."
      redirect_to '/home'
    end
  end

  #require_admin() - If a user attempts to access a page that is restricted to admins, forbids 
  #them from accessing the page and redirects to home
  def require_admin
    unless current_user && current_user.active_state?
      flash[:warning] = "You are not authorized to access this page."
      redirect_to '/home'
    end
  end


end
