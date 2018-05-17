class EventStatesController < ApplicationController
	before_action :client_check, only: [:cl_accept, :cl_dismiss, :cl_deliver, :cl_cancele]
	before_action :customer_check, only: [:cs_request_cancele, :cs_cancele, :cs_accept, :cs_dismiss, :cs_recieve]
	before_action :cl_deliver_check, only: [:cl_deliver]

	before_action :state_requested, only: [:cl_accept, :cl_dismiss, :cs_request_cancele]
	before_action :state_accepted, only: [:cl_cancele, :cl_deliver, :cs_cancele]
	before_action :state_edited, only: [:cs_accept, :cs_dismiss]
	before_action :state_deliverd, only: [:cs_recieve]

	def cl_accept
		EventState.create(event_id: event_id_params, comment: comment_params, state: "cl_accepted" )

		event = Event.find(event_id_params)

		# 通知メール
		reciever = event.customer.user
		if reciever.mail_refused == false
			sender = event.client.user
			message = comment_params
			day = event.start_time.strftime('%Y/%m/%d')
			wday = l(day.to_date, format: :wday)
			start_time = event.start_time.strftime('%H:%M')
			end_time  = event.end_time.strftime('%H:%M')
			prefecture = event.prefecture.ja
			location_detail = event.location_detail
			num_people = event.num_people
			total_price = event.total_price
			primary_price_sum = event.primary_price_sum
			options = event.event_option_prices
			reciever_mail = reciever.email
			sender_name = sender.name
			link = 'https://www.camera-to-culture.com/events/' + event.id.to_s
			state = "cl_accepted"
			ReserveMailer.ev_state_changed(message, day, wday, start_time, end_time, prefecture, location_detail, num_people, total_price, primary_price_sum, options, reciever_mail, sender_name, link, state).deliver_now
		end

		redirect_to event_path(event_id_params)
	end

	def cl_deliver
		EventState.create(event_id: event_id_params, comment: comment_params, state: "cl_delivered" )

		event = Event.find(event_id_params)

		# 通知メール
		reciever = event.customer.user
		if reciever.mail_refused == false
			sender = event.client.user
			message = comment_params
			day = event.start_time.strftime('%Y/%m/%d')
			wday = l(day.to_date, format: :wday)
			start_time = event.start_time.strftime('%H:%M')
			end_time  = event.end_time.strftime('%H:%M')
			prefecture = event.prefecture.ja
			location_detail = event.location_detail
			num_people = event.num_people
			total_price = event.total_price
			primary_price_sum = event.primary_price_sum
			options = event.event_option_prices
			reciever_mail = reciever.email
			sender_name = sender.name
			link = 'https://www.camera-to-culture.com/events/' + event.id.to_s
			state = "cl_delivered"
			ReserveMailer.ev_state_changed(message, day, wday, start_time, end_time, prefecture, location_detail, num_people, total_price, primary_price_sum, options, reciever_mail, sender_name, link, state).deliver_now
		end

		redirect_to event_path(event_id_params)
	end

	def cs_accept
		EventState.create(event_id: event_id_params, comment: comment_params, state: "cs_accepted" )

		event = Event.find(event_id_params)

		# 通知メール
		reciever = event.client.user
		if reciever.mail_refused == false
			sender = event.customer.user
			message = comment_params
			day = event.start_time.strftime('%Y/%m/%d')
			wday = l(day.to_date, format: :wday)
			start_time = event.start_time.strftime('%H:%M')
			end_time  = event.end_time.strftime('%H:%M')
			prefecture = event.prefecture.ja
			location_detail = event.location_detail
			num_people = event.num_people
			total_price = event.total_price
			primary_price_sum = event.primary_price_sum
			options = event.event_option_prices
			reciever_mail = reciever.email
			sender_name = sender.name
			link = 'https://www.camera-to-culture.com/events/' + event.id.to_s
			state = "cs_accepted"
			ReserveMailer.ev_state_changed(message, day, wday, start_time, end_time, prefecture, location_detail, num_people, total_price, primary_price_sum, options, reciever_mail, sender_name, link, state).deliver_now
		end

		redirect_to event_path(event_id_params)
	end


	def cl_dismiss
		EventState.create(event_id: event_id_params, comment: comment_params, state: "cl_dismissed" )

		event = Event.find(event_id_params)

		# 通知メール
		reciever = event.customer.user
		if reciever.mail_refused == false
			sender = event.client.user
			message = comment_params
			day = event.start_time.strftime('%Y/%m/%d')
			wday = l(day.to_date, format: :wday)
			start_time = event.start_time.strftime('%H:%M')
			end_time  = event.end_time.strftime('%H:%M')
			prefecture = event.prefecture.ja
			location_detail = event.location_detail
			num_people = event.num_people
			total_price = event.total_price
			primary_price_sum = event.primary_price_sum
			options = event.event_option_prices
			reciever_mail = reciever.email
			sender_name = sender.name
			link = 'https://www.camera-to-culture.com/events/' + event.id.to_s
			state = "cl_dismissed"
			ReserveMailer.ev_state_changed(message, day, wday, start_time, end_time, prefecture, location_detail, num_people, total_price, primary_price_sum, options, reciever_mail, sender_name, link, state).deliver_now
		end

		redirect_to event_path(event_id_params)
	end

	def cs_dismiss
		EventState.create(event_id: event_id_params, comment: comment_params, state: "cs_dismissed" )

		event = Event.find(event_id_params)

		# 通知メール
		reciever = event.client.user
		if reciever.mail_refused == false
			sender = event.customer.user
			message = comment_params
			day = event.start_time.strftime('%Y/%m/%d')
			wday = l(day.to_date, format: :wday)
			start_time = event.start_time.strftime('%H:%M')
			end_time  = event.end_time.strftime('%H:%M')
			prefecture = event.prefecture.ja
			location_detail = event.location_detail
			num_people = event.num_people
			total_price = event.total_price
			primary_price_sum = event.primary_price_sum
			options = event.event_option_prices
			reciever_mail = reciever.email
			sender_name = sender.name
			link = 'https://www.camera-to-culture.com/events/' + event.id.to_s
			state = "cs_dismissed"
			ReserveMailer.ev_state_changed(message, day, wday, start_time, end_time, prefecture, location_detail, num_people, total_price, primary_price_sum, options, reciever_mail, sender_name, link, state).deliver_now
		end

		redirect_to event_path(event_id_params)
	end

	def cs_request_cancele
		EventState.create(event_id: event_id_params, comment: comment_params, state: "cs_request_canceled" )

		event = Event.find(event_id_params)

		# 通知メール
		reciever = event.client.user
		if reciever.mail_refused == false
			sender = event.customer.user
			message = comment_params
			day = event.start_time.strftime('%Y/%m/%d')
			wday = l(day.to_date, format: :wday)
			start_time = event.start_time.strftime('%H:%M')
			end_time  = event.end_time.strftime('%H:%M')
			prefecture = event.prefecture.ja
			location_detail = event.location_detail
			num_people = event.num_people
			total_price = event.total_price
			primary_price_sum = event.primary_price_sum
			options = event.event_option_prices
			reciever_mail = reciever.email
			sender_name = sender.name
			link = 'https://www.camera-to-culture.com/events/' + event.id.to_s
			state = "cs_request_canceled"
			ReserveMailer.ev_state_changed(message, day, wday, start_time, end_time, prefecture, location_detail, num_people, total_price, primary_price_sum, options, reciever_mail, sender_name, link, state).deliver_now
		end

		redirect_to event_path(event_id_params)
	end

	def cs_cancele
		EventState.create(event_id: event_id_params, comment: comment_params, state: "cs_canceled" )

		event = Event.find(event_id_params)

		# 通知メール
		reciever = event.client.user
		if reciever.mail_refused == false
			sender = event.customer.user
			message = comment_params
			day = event.start_time.strftime('%Y/%m/%d')
			wday = l(day.to_date, format: :wday)
			start_time = event.start_time.strftime('%H:%M')
			end_time  = event.end_time.strftime('%H:%M')
			prefecture = event.prefecture.ja
			location_detail = event.location_detail
			num_people = event.num_people
			total_price = event.total_price
			primary_price_sum = event.primary_price_sum
			options = event.event_option_prices
			reciever_mail = reciever.email
			sender_name = sender.name
			link = 'https://www.camera-to-culture.com/events/' + event.id.to_s
			state = "cs_canceled"
			ReserveMailer.ev_state_changed(message, day, wday, start_time, end_time, prefecture, location_detail, num_people, total_price, primary_price_sum, options, reciever_mail, sender_name, link, state).deliver_now
		end

		redirect_to event_path(event_id_params)
	end


	def cl_cancele
		EventState.create(event_id: event_id_params, comment: comment_params, state: "cl_canceled" )

		event = Event.find(event_id_params)

		# 通知メール
		reciever = event.customer.user
		if reciever.mail_refused == false
			sender = event.client.user
			message = comment_params
			day = event.start_time.strftime('%Y/%m/%d')
			wday = l(day.to_date, format: :wday)
			start_time = event.start_time.strftime('%H:%M')
			end_time  = event.end_time.strftime('%H:%M')
			prefecture = event.prefecture.ja
			location_detail = event.location_detail
			num_people = event.num_people
			total_price = event.total_price
			primary_price_sum = event.primary_price_sum
			options = event.event_option_prices
			reciever_mail = reciever.email
			sender_name = sender.name
			link = 'https://www.camera-to-culture.com/events/' + event.id.to_s
			state = "cl_canceled"
			ReserveMailer.ev_state_changed(message, day, wday, start_time, end_time, prefecture, location_detail, num_people, total_price, primary_price_sum, options, reciever_mail, sender_name, link, state).deliver_now
		end

		redirect_to event_path(event_id_params)
	end

	include ActionController::Streaming
	include Zipline
	def cs_recieve
		# state作成
		EventState.create(event_id: event_id_params, comment: comment_params, state: "cs_recieved" )

		# zip_dl
		ev_photos = EventPhoto.from_ev(event_id_params).active.image_present
		respond_to do |format|
			format.html
			format.zip do
				files =  ev_photos.map{ |ev_photo| [ev_photo.image, "#{ev_photo.id}.jpg"] }
				zipline(files, 'Camera-to-Culture-Photos_' + Time.now().to_s + '.zip')
			end
		end

		event = Event.find(event_id_params)

		# 通知メール
		reciever = event.client.user
		if reciever.mail_refused == false
			sender = event.customer.user
			message = comment_params
			day = event.start_time.strftime('%Y/%m/%d')
			wday = l(day.to_date, format: :wday)
			start_time = event.start_time.strftime('%H:%M')
			end_time  = event.end_time.strftime('%H:%M')
			prefecture = event.prefecture.ja
			location_detail = event.location_detail
			num_people = event.num_people
			total_price = event.total_price
			primary_price_sum = event.primary_price_sum
			options = event.event_option_prices
			reciever_mail = reciever.email
			sender_name = sender.name
			link = 'https://www.camera-to-culture.com/events/' + event.id.to_s
			state = "cs_recieved"
			ReserveMailer.ev_state_changed(message, day, wday, start_time, end_time, prefecture, location_detail, num_people, total_price, primary_price_sum, options, reciever_mail, sender_name, link, state).deliver_now
		end
	end


private
	#---------- params ----------#
	def comment_params
		params[:comment]
	end

	def event_id_params
		params[:event_id].to_i
	end




	#---------- state_check ----------#
	def state_requested
		event = Event.find(params[:event_id].to_i)
		unless event.event_states.last.state == "request"
			flash[:alert] = "リクエストが不正です"
			redirect_to root_path
		end
	end

	def state_accepted
		event = Event.find(params[:event_id].to_i)
		unless event.event_states.last.state.in?(['cl_accepted','cs_accepted'])
			flash[:alert] = "リクエストが不正です"
			redirect_to root_path
		end
	end

	def state_edited
		event = Event.find(params[:event_id].to_i)
		unless event.event_states.last.state == "cl_edited"
			flash[:alert] = "リクエストが不正です"
			redirect_to root_path
		end
	end

	def state_deliverd
		event = Event.find(params[:event_id].to_i)
		unless event.event_states.last.state == "cl_delivered"
			flash[:alert] = "リクエストが不正です"
			redirect_to root_path@ev_photo_nums > 0
		end
	end


	def cl_deliver_check
		event = Event.find(params[:event_id].to_i)
		unless event.event_photos.present? && event.event_photos.count > 0
			flash[:alert] = "リクエストが不正です"
			redirect_to root_path
		end
	end

	#---------- user_check ----------#
	def client_check
		event = Event.find(params[:event_id])
		user = current_user
		cl = user.client
		unless user_signed_in? &&( event.client_id == cl.id )
			flash[:alert] = "ログインしてください"
			redirect_to root_path
		end
	end

	def customer_check
		event = Event.find(params[:event_id])
		user = current_user
		cs = user.customer
		unless user_signed_in? &&( event.customer_id == cs.id)
			flash[:alert] = "ログインしてください"
			redirect_to root_path
		end
	end


end