class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user, :logged_in?, :is_same_user?

  def current_user
  	@current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
  	!!current_user
  end

  def is_same_user?
    post = Post.find(params[:id])
    !!(current_user == post.user)
  end

  def require_user
  	if !logged_in?
  		flash[:error]='Must be logged in to do that'
  		redirect_to root_path
  	end
  end

  def require_same_user
  	if current_user != @user
  		flash[:error] = 'You cant do that'
  		redirect_to root_path
  	end
  end
end
