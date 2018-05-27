class ClientPortfoliosController < ApplicationController
	before_action :user_check, only: [:new, :create, :r_destroy]
	before_action :consent_check, only: :new

	def new
		@user = current_user
		@cl = @user.client
		@num = @cl.client_portfolios.active.count
		@cs = @user.customer
		@locale = params[:locale]
		@portfolios = @cl.client_portfolios.active.limit(19)
		@portfolio_nums = @cl.client_portfolios.active.count
	end

	def create
		cl = current_user.client
		num = cl.client_portfolios.active.count
		if num < 20
			ClientPortfolio.create(create_params)
		end
	end

	def r_destroy
		# 一応、current_userかチェックしてから消去
		for id in params[:delete_portfolio]
			cl_pf = ClientPortfolio.find(id)
			if cl_pf.client_id == params[:client_id].to_i
				cl_pf.update(deleted_at: Time.now)
			end
		end


		@user = current_user
		@cl = @user.client
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
			flash[:alert] = t(".Please_login")
			redirect_to root_path
		end
	end

	def consent_check
		cl = Client.find(params[:client_id])
		unless cl.consent == true && cl.deleted_at == nil
			flash[:alert] = t(".The_page_does_not_exist")
			redirect_to root_path
		end
	end
end