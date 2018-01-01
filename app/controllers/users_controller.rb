class UsersController < ApplicationController
	# before_action :authenticate_user!, only: :show
	before_action :login_check, only: :show

	def show
		@user = current_user
		@cl = @user.clients.active.first
		@cs = @user.customers.active.first
		langs = @user.user_languages

		@mylangs = []
		langs.each do |lang|
			@mylangs << lang.language
		end
	end




private
	def login_check
		unless user_signed_in? && params[:id].to_i == current_user.id
			flash[:alert] = "ログインしてください"
			redirect_to root_path
		end
	end
end