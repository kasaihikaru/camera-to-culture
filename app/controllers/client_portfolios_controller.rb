class ClientPortfoliosController < ApplicationController
before_action :user_check, only: [:new, :r_destroy]


	def new
		@user = current_user
		@cl = @user.clients.active.first
		@cs = @user.customers.active.first
		@locale = params[:locale]
		@portfolios = @cl.client_portfolios.active
	end

	def create
		ClientPortfolio.create(create_params)
	end

	def r_destroy
		# 一応、current_userかチェックしてから消去
		for id in params[:delete_portfolio]
			cl_pf = ClientPortfolio.find(id)
			if cl_pf.client_id == params[:client_id].to_i
				cl_pf.update(is_deleted: true)
			end
		end


		@user = current_user
		@cl = @user.clients.active.first
		redirect_to new_client_client_portfolio_path(@cl)
	end


#------ストロングパラメーター------#
private
	def create_params
		portfolio = {}
		portfolio[:image] = params[:client_portfolio]
		portfolio[:client_id] = params[:client_id].to_i
		return portfolio
	end



	def r_destroy_params
		params[:delete_portfolio]
	end

	def user_check
		unless user_signed_in? && Client.find(params[:client_id]).user == current_user
			flash[:alert] = "ログインしてください"
			redirect_to root_path
		end
	end

end