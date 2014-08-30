class UsersController < ApplicationController
	before_action :signed_in_user, 	only: [:index, :edit, :update, :destroy]  
	before_action :correct_user,	only: [:edit, :update]
	before_action :admin_user,		only: :destroy

	def index
		@users = User.paginate(page: params[:page])
	end

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

	def edit
		# @user = User.find(params[:id])
		# why was this removed after before_action :correct_user was added?
	end

	def update
		# @user = User.find(params[:id])
		# this too.
		# Tutorial says "Now that the correct_user before filter defines @user, we can omit it"
		if @user.update_attributes(user_params)
			flash[:success] = "Profile updated"
			redirect_to @user
		else
			render 'edit'
		end
	end

	def destroy
		User.find(params[:id]).destroy
		flash[:success] = "User deleted."
		redirect_to users_url
	end

	private
	# Why does the test fail when I comment this section out?
	# It says 'param' method undefined. How is that related to user_params?
	# What about the 'params[:id]' section above?
		def user_params # Was this automatically generated then modified, or completely new?
			params.require(:user).permit(:name, :email, :password, :password_confirmation)
		end

		# Before filters

		def signed_in_user
			unless signed_in?
				store_location
				redirect_to signin_url, notice: "Please sign in."
			# redirect_to signin_url, notice: "Please sign in." unless signed_in?
			end
		end

		def correct_user
			@user = User.find(params[:id])
			redirect_to(root_url) unless current_user?(@user)
		end

		def admin_user
			redirect_to(root_url) unless current_user.admin?
		end
end
