class SessionsController < ApplicationController
	def new

	end

	def create
		user = User.find_by(username: params[:username])

		if user && user.authenticate(params[:password])
			session[:user_id] = user.id
			flash[:notice]='Login Success!!'
			redirect_to root_path
		else
			flash[:error]='Wrong user information'
			redirect_to login_path
		end
	end

	def destroy
		session[:user_id] = nil
		flash[:notice]='You have been logged out'
		redirect_to root_path
	end
end