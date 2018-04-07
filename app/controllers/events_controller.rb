class EventsController < ApplicationController
	before_action :login_check, only: [:new, :create]
	before_action :event_show_user_check, only: [:show]


	def cs_future
		@user = current_user
		@cl = @user.clients.active.first
		@cs = @user.customers.active.first
	end

	def cs_past
		@user = current_user
		@cl = @user.clients.active.first
		@cs = @user.customers.active.first
	end

	def cl_future
		@user = current_user
		@cl = @user.clients.active.first
		@cs = @user.customers.active.first

		@events = Event.as_cl(@cl.id).request.includes(:prefecture, customer: :user)
	end

	def cl_past
		@user = current_user
		@cl = @user.clients.active.first
		@cs = @user.customers.active.first
	end


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
		@options = @event.event_option_prices.includes(:client_option_price)
		@ev_prim_price = @event.event_primary_prices.first
		@prim_price = @ev_prim_price.client_primary_price
		@event_state_now = @event.event_states.last

		# @event_state = EventState.new
	end

	def create
		# イベント作成
		if ev_create_params.kind_of?(String) then
			if ev_create_params == "time-error" then
				flash[:alert] = "リクエスト時間が足りません"
				redirect_to new_event_path(id: event_client_id_params)
			elsif
				flash[:alert] = "金額がマイナスの値です"
				redirect_to new_event_path(id: event_client_id_params)
			else
				flash[:alert] = "オプションの数が不正です"
				redirect_to new_event_path(id: event_client_id_params)
			end
		else
			event = Event.create(ev_create_params)

			# ev_prim_price_table
			prim_price = ev_prim_price_params.merge(event_id: event.id)
			EventPrimaryPrice.create(prim_price)

			# ev_opt_price_table
			for opt in ev_opt_price_params do
				opt_price = opt.merge(event_id: event.id)
				EventOptionPrice.create(opt_price)
			end

			# ev_states_table
			EventState.create(event_id: event.id, state: "request")

			redirect_to event_path(event)
		end
	end



private
	def ev_create_params
		# 時間
		start_time = ev_hours_params["start_time"]
		end_time = ev_hours_params["end_time"]
		hours = ev_hours_params["hours"]
		# マイナスならエラーを返す
		if hours <= 0 then
			return "time-error"
		end

		# メイン価格
		client_id = params[:event][:client_id].to_i
		cl = Client.find(client_id)
		prim_price_ins = cl.client_primary_prices.active.first
		client_primary_price_id = prim_price_ins.id
		prim_price = prim_price_ins.price_per_hour
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
		if total_price <= 0 then
			return "total-fee-error"
		end

		x = params.require(:event).permit(:location_detail, :num_people, :message).merge(client_id: client_id ,customer_id: current_user.id, prefecture_id: params[:prefecture_id].to_i, start_time: start_time, end_time: end_time, total_price: total_price, primary_price_sum: primary_price_sum, option_price_sum: option_price_sum)
		return x
	end


	def ev_hours_params
		# 時間
		start_time = DateTime.parse(params[:date] + " " + params[:event][:start_time] + " +0900")
		end_time = DateTime.parse(params[:date] + " " + params[:event][:end_time] + " +0900")
		hours = (end_time - start_time).to_f * 24

		x = {}
		x = {"start_time" => start_time, "end_time" => end_time, "hours" => hours}
		return x
	end


	def ev_prim_price_params
		#時間
		hours = ev_hours_params["hours"]

		# メイン価格
		client_id = params[:event][:client_id].to_i
		cl = Client.find(client_id)
		prim_price_ins = cl.client_primary_prices.active.first
		client_primary_price_id = prim_price_ins.id
		prim_price = prim_price_ins.price_per_hour
		primary_price_sum = (prim_price * hours).floor

		x = {}
		x = {"client_primary_price_id" => client_primary_price_id, "hours" => hours, "price_sum" => primary_price_sum}
		return x
	end


	def ev_opt_price_params
		#時間
		hours = ev_hours_params["hours"]

		# オプション価格
		options = params[:event][:event_option_prices_attributes]
		x = []
		options.each do |key, value|
			a = {}
			opt = ClientOptionPrice.find(key)
			client_option_price_id = opt.id
			numbers = value.to_i
			if opt.along_with_time == true
				option_price = opt.price * numbers * hours
			else
				option_price = opt.price * numbers
			end
			a = {"client_option_price_id" => client_option_price_id, "numbers" => numbers, "price_sum" => option_price.floor}
			x << a
		end
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