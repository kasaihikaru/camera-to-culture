class ClientPortfoliosController < ApplicationController

	def new
		@cl = current_user.clients.active.first
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
		# binding.pry
	end
end