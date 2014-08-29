class UsersController < ApplicationController
  
	def show
		@user = User.find(params[:id])
	end

	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		if @user.save
			sign_in @user
			flash[:success] = "Welcome to the Sample App!"
			redirect_to @user
		else
			render 'new'
		end
	end

	private
	# Why does the test fail when I comment this section out?
	# It says 'param' method undefined. How is that related to user_params?
	# What about the 'params[:id]' section above?
		def user_params # Was this automatically generated then modified, or completely new?
			params.require(:user).permit(:name, :email, :password, :password_confirmation)
		end
end
