class EventsController < ApplicationController

	def new
		@user = current_user
		@cl = @user.clients.active.first
		@cs = @user.customers.active.first

		@cl_here = Client.find(params[:id])
		@categories = @cl_here.client_categories.includes(:category)
		@langs = @cl_here.user.user_languages.includes(:language)
		@locations = @cl_here.client_locations.includes(:prefecture)
		@prim_price = @cl_here.client_primary_prices.active.first
		@options = @cl_here.client_option_prices.active
		@portfolios = @cl_here.client_portfolios
	end

	def show
		@user = current_user
		@cl = @user.clients.active.first
		@cs = @user.customers.active.first
	end

	def create
		
	end
end