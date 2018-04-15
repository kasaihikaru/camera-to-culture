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
		@cl = @user.clients.active.first
		@cl_categories = @cl.client_categories.includes(:category)
		@cl_prim_price = @cl.client_primary_prices.active.first
		@cl_opt_prices = @cl.client_option_prices.active
		@cl_locations = @cl.client_locations.includes(:prefecture)
		@cl_prefectures = []
		for cl_locations in @cl_locations
			@cl_prefectures << cl_locations.prefecture
		end
		@portfolio_nums = @cl.client_portfolios.active.count

		#customer_info
		@cs = @user.customers.active.first

		#event
		cl_evs = @cl.events.includes(customer: :user)
		cl_evs_future = cl_evs.future
		@cl_future = []
		for ev in cl_evs_future do
			if ev.event_states.last.state == "request"
				@cl_future << ev.event_states.last
			end
		end
		cl_evs_past = cl_evs.past
		@cl_past = []
		for ev in cl_evs_past do
			if ev.event_states.last.state.in?(['cl_accepted','cs_accepted'])
				@cl_past << ev.event_states.last
			end
		end

		cs_evs = @cs.events.includes(client: :user)
		cs_evs_future = cs_evs.future
		@cs_future = []
		for ev in cs_evs_future do
			if ev.event_states.last.state == "cl_edited"
				@cs_future << ev.event_states.last
			end
		end
		cs_evs_past = cs_evs.past
		@cs_past = []
		for ev in cs_evs_future do
			if ev.event_states.last.state == "cl_delivered"
				@cs_future << ev.event_states.last
			end
		end
	end


	private
	def user_check
		unless user_signed_in? && params[:id].to_i == current_user.id
			flash[:alert] = "ログインしてください"
			redirect_to root_path
		end
	end
end