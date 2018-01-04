class CustomersController < ApplicationController
	before_action :user_check, only: :edit

	def show
	end

	def edit
		@cs = current_user.customers.active.first
	end

	def create
	end


	private
	def user_check
		unless user_signed_in? && params[:user_id].to_i == current_user.id
			flash[:alert] = "ログインしてください"
			redirect_to root_path
		end
	end
end