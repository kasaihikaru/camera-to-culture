class EventsController < ApplicationController
	before_action :login_check, only: [:new, :create]


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

		######### カレンダー ###########
		@day = Date.today

		from_date = Date.new(@day.year, @day.month, @day.beginning_of_month.day).beginning_of_week(:sunday)
		to_date = Date.new(@day.year, @day.month, @day.end_of_month.day).end_of_week(:sunday)

		# カレンダーを書く用
		@c_dates = []
		(from_date..to_date).each do |d|
			sch = ClientSchedule.find_by(client_id: @cl_here.id, date: d)

			date = {}
			date["date"] = d
			if sch.present?
				date["schedule"] = sch.schedule
			end
			@c_dates << date
		end


		######### インスタンス渡す ########
		@event = Event.new
		@event.event_option_prices.build

	end

	def show
		@user = current_user
		@cl = @user.clients.active.first
		@cs = @user.customers.active.first
	end

	def create
		binding.pry
	end



private
	def ev_create_params
		start_time = DateTime.parse(params[:date] + " " + params[:event][:start_time])
		end_time = DateTime.parse(params[:date] + " " + params[:event][:end_time])


		x = params.require(:event).permit(:location_detail, :num_people, :message).merge(client_id: param[:client_id] ,customer_id: current_user.id, prefecture_id: param[:prefecture_id], start_time: start_time, end_time: end_time,  )
	end



	def login_check
		unless user_signed_in?
			flash[:alert] = "ログインしてください"
			redirect_to root_path
		end
	end
end