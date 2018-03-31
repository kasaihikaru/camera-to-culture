class EventsController < ApplicationController
	before_action :login_check, only: [:new, :create]
	before_action :event_show_user_check, only: [:show]


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
		@event = Event.find(id_params)
		@cl_here = Client.find(@event.client_id)
		@cs_here = Customer.find(@event.customer_id)
		@day = @event.start_time.strftime('%Y/%m/%d')
		@wday = l(@day.to_date, format: :wday)
		@start_time = @event.start_time.strftime('%H:%M')
		@end_time  = @event.end_time.strftime('%H:%M')
		@prefecture = @event.prefecture
		@options = @event.event_option_prices
	end

	def create
		if ev_create_params.kind_of?(String) then
			flash[:alert] = "リクエスト時間が足りません"
			redirect_to new_event_path(id: event_client_id_params)
		else
			event = Event.create(ev_create_params)
			redirect_to event_path(event)
		end
	end



private
	def ev_create_params
		# 時間
		start_time = DateTime.parse(params[:date] + " " + params[:event][:start_time] + " +0900")
		end_time = DateTime.parse(params[:date] + " " + params[:event][:end_time] + " +0900")
		hours = (end_time - start_time).to_f * 24
		# マイナスならエラーを返す
		if hours <= 0 then
			return "time-error"
		end

		# メイン価格
		client_id = params[:event][:client_id].to_i
		cl = Client.find(client_id)
		prim_price = cl.client_primary_prices.active.first.price_per_hour
		primary_price_sum = (prim_price * hours).floor

		# オプション価格
		options = params[:event][:event_option_prices_attributes]
		option_price_sum = 0
		options.each do |key, value|
			if value.to_i < 0 then
				return "opt-num-error"
			else
				opt = ClientOptionPrice.find(key)
				if opt.along_with_time == true
					option_price = opt.price * value.to_i * hours
				else
					option_price = opt.price * value.to_i
				end
				option_price_sum = (option_price_sum + option_price).floor
			end
		end

		# 合計価格
		total_price = primary_price_sum + option_price_sum

		x = params.require(:event).permit(:location_detail, :num_people, :message).merge(client_id: client_id ,customer_id: current_user.id, prefecture_id: params[:prefecture_id].to_i, start_time: start_time, end_time: end_time, total_price: total_price, primary_price_sum: primary_price_sum, option_price_sum: option_price_sum)
		return x
	end

	def event_client_id_params
		client_id = params[:event][:client_id].to_i
	end

	def id_params
		params[:id]
	end


	def login_check
		unless user_signed_in?
			flash[:alert] = "ログインしてください"
			redirect_to root_path
		end
	end

	def event_show_user_check
		event = Event.find(params[:id])
		@user = current_user
		@cl = @user.clients.active.first
		@cs = @user.customers.active.first
		unless user_signed_in? &&(
				event.client_id == @cl.id || event.customer_id == @cs.id
			)
			flash[:alert] = "ログインしてください"
			redirect_to root_path
		end
	end
end