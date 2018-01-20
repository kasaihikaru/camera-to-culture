class EventsController < ApplicationController

	def new
		@cl = Client.find(params[:id])
		@categories = @cl.client_categories.includes(:category)
		@langs = @cl.user.user_languages.includes(:language)
		@locations = @cl.client_locations.includes(:prefecture)
		@prim_price = @cl.client_primary_prices.active.first
		@options = @cl.client_option_prices.active
		@portfolios = @cl.client_portfolios
	end

	def show
		
	end

	def create
		
	end
end