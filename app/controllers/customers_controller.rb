class CustomersController < ApplicationController
	before_action :user_check, only: :edit

	def show
	end

	def edit
		@user = current_user
		@cl = @user.clients.active.first
		@cs = @user.customers.active.first
	end

	def update
		@user = current_user
		@cl = @user.clients.active.first
		@cs = @user.customers.active.first

		@cs.update(update_params)

		flash[:alert] = "更新しました"
		redirect_to edit_user_customer_path(@user, @cs)
	end


private

	def update_params
		params.require(:customer).permit(:introduction).merge(id: params[:id])
	end

	def user_check
		unless user_signed_in? && params[:user_id].to_i == current_user.id && Customer.find(params[:id]).user == current_user
			flash[:alert] = "ログインしてください"
			redirect_to root_path
		end
	end
end