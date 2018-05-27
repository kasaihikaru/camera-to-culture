class EventsController < ApplicationController
	before_action :login_check, only: [:new, :create, :cs_future, :cs_past, :cl_future, :cl_past]
	before_action :event_show_user_check, only: [:show]
	before_action :event_edit_user_check, only: [:edit]
	before_action :update_user_check, only: [:update]


	def cs_future
		import_current_user
		@events = Event.as_cs(@cs.id).future.request.includes(:prefecture, client: :user).order(start_time: :DESC)
	end

	def cs_past
		import_current_user
		@events = Event.as_cs(@cs.id).past.request.includes(:prefecture, :event_review, client: :user).order(start_time: :DESC)
	end

	def cl_future
		import_current_user
		@events = Event.as_cl(@cl.id).future.request.includes(:prefecture, customer: :user).order(start_time: :DESC)
	end

	def cl_past
		import_current_user
		@events = Event.as_cl(@cl.id).past.request.includes(:prefecture, :event_review, customer: :user).order(start_time: :DESC)
	end


	def new
		import_current_user

		@cl_here = Client.find(id_params)
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

	def edit
		import_current_user

		@event = Event.find(id_params)
		@ev_date = @event.start_time.to_date
		@ev_prim_price = @event.event_primary_prices.last
		@prim_price = @event.event_primary_prices.last.client_primary_price
		@ev_options = @event.event_option_prices.includes(:client_option_price)
		@ev_opt_ids = []
		for opt in @ev_options do
			@ev_opt_ids << opt.client_option_price_id
		end

		@cl_here = Client.find(client_id_params)
		@options = @cl_here.client_option_prices.active
		opt_ids = []
		for opt in @options do
			opt_ids << opt.id
		end
		@opt_diff = opt_ids - @ev_opt_ids

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

		@i = 0
		@x = 1000
		@y = 1000
	end

	def create
		# イベント作成
		if ev_create_params.kind_of?(String) then
			if ev_create_params == "time-error" then
				flash[:alert] = t(".Requested_time_is_invalid")
				redirect_to new_event_path(id: event_client_id_params)
			elsif ev_create_params == "total-fee-error" then
				flash[:alert] = t(".Requested_price_is_invalid")
				redirect_to new_event_path(id: event_client_id_params)
			else
				flash[:alert] = t(".Requested_option_menu_is_invalid")
				redirect_to new_event_path(id: event_client_id_params)
			end
		else
			event = Event.create(ev_create_params)

			# ev_prim_price_table
			prim_price = ev_prim_price_params.merge(event_id: event.id)
			EventPrimaryPrice.create(prim_price)

			# ev_opt_price_table
			if ev_opt_price_params != 0
				for opt in ev_opt_price_params do
					opt_price = opt.merge(event_id: event.id)
					EventOptionPrice.create(opt_price)
				end
			end

			# ev_states_table
			EventState.create(event_id: event.id, state: "request")

			# 通知メール
			reciever = Client.find(event_client_id_params).user
			sender = current_user
			if reciever.mail_refused == false
				message = ev_create_params[:message]
				day = ev_hours_params["start_time"].strftime('%Y/%m/%d')
				wday = l(day.to_date, format: :wday)
				start_time = ev_hours_params["start_time"].strftime('%H:%M')
				end_time  = ev_hours_params["end_time"].strftime('%H:%M')
				prefecture = Prefecture.find(ev_create_params[:prefecture_id]).ja
				location_detail = ev_create_params[:location_detail]
				num_people = ev_create_params[:num_people]
				total_price = ev_create_params[:total_price]
				primary_price_sum = ev_create_params[:primary_price_sum]
				options = event.event_option_prices
				reciever_mail = reciever.email
				sender_name = sender.name
				link = 'https://www.camera-to-culture.com/' + event.id.to_s
				ReserveMailer.cs_requested(message, day, wday, start_time, end_time, prefecture, location_detail, num_people, total_price, primary_price_sum, options, reciever_mail, sender_name, link).deliver_now
			end

			redirect_to event_path(event)
		end
	end

	def update
		# イベント作成
		if ev_edit_params.kind_of?(String) then
			if ev_edit_params == "time-error" then
				flash[:alert] = t(".Requested_time_is_invalid")
				redirect_to new_event_path(id: event_client_id_params)
			elsif ev_edit_params == "total-fee-error" then
				flash[:alert] = t(".Requested_price_is_invalid")
				redirect_to new_event_path(id: event_client_id_params)
			else
				flash[:alert] = t(".Requested_option_menu_is_invalid")
				redirect_to new_event_path(id: event_client_id_params)
			end
		else
			event = Event.find(id_params)
			event.update(ev_edit_params)

			# ev_prim_price_table
			ev_prim_price = event.event_primary_prices.last
			ev_prim_price.update(edit_ev_prim_price_params)

			# ev_opt_price_table
			if ev_opt_price_params != 0
				for opt in ev_opt_price_params do
					opt_price = opt.merge(event_id: event.id)
					ev_opt = EventOptionPrice.find_by(event_id: event.id, client_option_price_id: opt["client_option_price_id"])
					if ev_opt.present?
						ev_opt.update(opt_price)
					else
						EventOptionPrice.create(opt_price)
					end
				end
			end

			# ev_states_table
			EventState.create(event_id: event.id, state: "cl_edited", comment: comment_params)

			# 通知メール
			reciever = current_user
			sender = event.customer.user
			if reciever.mail_refused == false
				message = ev_create_params[:message]
				day = ev_hours_params["start_time"].strftime('%Y/%m/%d')
				wday = l(day.to_date, format: :wday)
				start_time = ev_hours_params["start_time"].strftime('%H:%M')
				end_time  = ev_hours_params["end_time"].strftime('%H:%M')
				prefecture = event.prefecture.ja
				location_detail = event.location_detail
				num_people = event.num_people
				total_price = ev_create_params[:total_price]
				primary_price_sum = ev_create_params[:primary_price_sum]
				options = event.event_option_prices
				reciever_mail = reciever.email
				sender_name = sender.name
				link = 'https://www.camera-to-culture.com/' + event.id.to_s
				state = "cl_edited"
				ReserveMailer.ev_state_changed(message, day, wday, start_time, end_time, prefecture, location_detail, num_people, total_price, primary_price_sum, options, reciever_mail, sender_name, link, state).deliver_now
			end

			redirect_to event_path(event)
		end
	end

	def show
		import_current_user
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
		@ev_photos = @event.event_photos.active
		@ev_photo_nums = @ev_photos.count
		@ev_photos_6 = @event.event_photos.active.limit(6)
		if @event.event_review.present?
			@ev_rev = @event.event_review
		else
			@ev_rev = EventReview.new
		end
		@locale = params[:locale]
	end




private
	#------------ create params -------------#
	def ev_create_params
		# 時間
		start_time = ev_hours_params["start_time"]
		end_time = ev_hours_params["end_time"]
		hours = ev_hours_params["hours"]
		# マイナスならエラーを返す
		if hours <= 0 then
			return "time-error"
		end

		# 撮影価格
		client_id = params[:event][:client_id].to_i
		cl = Client.find(client_id)
		prim_price_ins = cl.client_primary_prices.active.first
		client_primary_price_id = prim_price_ins.id
		prim_price = prim_price_ins.price_per_hour
		primary_price_sum = (prim_price * hours).floor


		# オプション価格
		options = params[:event][:event_option_prices_attributes]
		if options.present?
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
		else
			# 合計価格
			total_price = primary_price_sum
			if total_price <= 0 then
				return "total-fee-error"
			end

			x = params.require(:event).permit(:location_detail, :num_people, :message).merge(client_id: client_id ,customer_id: current_user.id, prefecture_id: params[:prefecture_id].to_i, start_time: start_time, end_time: end_time, total_price: total_price, primary_price_sum: primary_price_sum, option_price_sum: 0)
			return x
		end
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

		# 撮影価格
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
		if options.present?
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
		else
			return 0
		end
	end


	#------------ edit -------------#
	def ev_edit_params
		# 時間
		start_time = ev_hours_params["start_time"]
		end_time = ev_hours_params["end_time"]
		hours = ev_hours_params["hours"]
		# マイナスならエラーを返す
		if hours <= 0 then
			return "time-error"
		end

		# 撮影価格
		event = Event.find(id_params)
		prim_price = event.event_primary_prices.last.client_primary_price.price_per_hour
		primary_price_sum = (prim_price * hours).floor


		# オプション価格
		options = params[:event][:event_option_prices_attributes]
		if options.present?
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
			y = {}
			x = y.merge(start_time: start_time, end_time: end_time, total_price: total_price, primary_price_sum: primary_price_sum, option_price_sum: option_price_sum)
			return x
		else
			# 合計価格
			total_price = primary_price_sum
			if total_price <= 0 then
				return "total-fee-error"
			end

			y = {}
			x = y.merge(start_time: start_time, end_time: end_time, total_price: total_price, primary_price_sum: primary_price_sum, option_price_sum: 0)
			return x
		end
	end


	def edit_ev_prim_price_params
		#時間
		hours = ev_hours_params["hours"]

		# 撮影価格
		event = Event.find(id_params)
		prim_price = event.event_primary_prices.last.client_primary_price.price_per_hour
		primary_price_sum = (prim_price * hours).floor

		x = {}
		x = {"hours" => hours, "price_sum" => primary_price_sum}
		return x
	end




	def event_client_id_params
		client_id = params[:event][:client_id].to_i
	end


	def id_params
		params[:id]
	end

	def client_id_params
		params[:client_id]
	end

	def comment_params
		params[:comment]
	end

	def login_check
		unless user_signed_in?
			flash[:alert] = t(".Please_login")
			redirect_to root_path
		end
	end

	def update_user_check
		event = Event.find(id_params)
		cl = Client.find(event.client_id)
		unless user_signed_in? && cl.user == current_user
			flash[:alert] = t(".Please_login")
			redirect_to root_path
		end
	end

	def event_show_user_check
		event = Event.find(params[:id])
		@user = current_user
		cl = @user.client
		cs = @user.customer
		unless user_signed_in? &&(
				event.client_id == cl.id || event.customer_id == cs.id
			)
			flash[:alert] = t(".Please_login")
			redirect_to root_path
		end
	end

	def event_edit_user_check
		event = Event.find(params[:id])
		cl_here = Client.find(params[:client_id])
		cl = current_user.client
		unless user_signed_in? &&	event.client_id == cl.id && cl_here == cl
			flash[:alert] = t(".Please_login")
			redirect_to root_path
		end
	end
end