class UsersController < ApplicationController
	# before_action :authenticate_user!, only: :show
	before_action :user_check, only: :show

	def show
		#user_info
		@user = current_user
		langs = @user.user_languages.includes(:language)
		@mylangs = []
		langs.each do |lang|
			@mylangs << lang.language
		end

		#client_info
		@cl = current_user.clients.active.first
		@cl_prim_price = @cl.client_primary_prices.active.first
		@cl_opt_prices = @cl.client_option_prices.active
		@cl_locations = @cl.client_locations.includes(:prefecture)
		@cl_prefectures = []
		for cl_locations in @cl_locations
			@cl_prefectures << cl_locations.prefecture
		end

		#customer_info
		@cs = current_user.customers.active.first

	end


	private
	def user_check
		unless user_signed_in? && params[:id].to_i == current_user.id
			flash[:alert] = "ログインしてください"
			redirect_to root_path
		end
	end
end