class ApplicationController < ActionController::Base
  before_action(:load_current_user)

  # Uncomment line 5 in this file and line 3 in UserAuthenticationController if you want to force users to sign in before any other actions.
  # before_action(:force_user_sign_in)

  def load_current_user
    the_id = session[:user_id]

    @current_user = User.where({ :id => the_id }).first
  end

  def force_user_sign_in
    if @current_user == nil
      redirect_to("/user_sign_in", { :notice => "You have to sign in first." })
    end
  end

  def homepage
    render({ :template => "index.html.erb" })
  end

  def private
    redirect_to("/", { :alert => "You are not allowed to do that." })
  end

  def users
    @the_user = User.where({ :username => params[:path_id] })[0]
    render({ :template => "users/show.html.erb" })
  end
end
