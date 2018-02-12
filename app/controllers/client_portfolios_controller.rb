class ClientPortfoliosController < ApplicationController
before_action :user_check, only: :new


	def new
		@user = current_user
		@cl = @user.clients.active.first
		@cs = @user.customers.active.first
		@locale = params[:locale]
		@portfolios = @cl.client_portfolios
	end

	def create
		ClientPortfolio.create(create_params)
	end

	def destroy

	end


#------ストロングパラメーター------#
private
	def create_params
		portfolio = {}
		portfolio[:image] = params[:client_portfolio]
		portfolio[:client_id] = params[:client_id].to_i
		return portfolio
	end

	def user_check
		unless user_signed_in? && Client.find(params[:client_id]).user == current_user
			flash[:alert] = "ログインしてください"
			redirect_to root_path
		end
	end

end