class EventStatesController < ApplicationController
	before_action :client_check, only: [:cl_accept, :cl_dismiss, :cl_deliver, :cl_cancele]
	before_action :customer_check, only: [:cs_request_cancele, :cs_cancele, :cs_accept, :cs_dismiss, :cs_recieve]

	before_action :state_requested, only: [:cl_accept, :cl_dismiss, :cs_request_cancele]
	before_action :state_accepted, only: [:cl_cancele, :cl_deliver, :cs_cancele]
	before_action :state_edited, only: [:cs_accept, :cs_dismiss]
	before_action :state_deliverd, only: [:cs_recieve]

	def cl_accept
		EventState.create(event_id: event_id_params, comment: comment_params, state: "cl_accepted" )
		redirect_to event_path(event_id_params)
	end

	def cl_deliver
		EventState.create(event_id: event_id_params, comment: comment_params, state: "cl_delivered" )
		redirect_to event_path(event_id_params)
	end

	def cs_accept
		EventState.create(event_id: event_id_params, comment: comment_params, state: "cs_accepted" )
		redirect_to event_path(event_id_params)
	end


	def cl_dismiss
		EventState.create(event_id: event_id_params, comment: comment_params, state: "cl_dismissed" )
		redirect_to event_path(event_id_params)
	end

	def cs_dismiss
		EventState.create(event_id: event_id_params, comment: comment_params, state: "cs_dismissed" )
		redirect_to event_path(event_id_params)
	end

	def cs_request_cancele
		EventState.create(event_id: event_id_params, comment: comment_params, state: "cs_request_canceled" )
		redirect_to event_path(event_id_params)
	end

	def cs_cancele
		EventState.create(event_id: event_id_params, comment: comment_params, state: "cs_canceled" )
		redirect_to event_path(event_id_params)
	end


	def cl_cancele
		EventState.create(event_id: event_id_params, comment: comment_params, state: "cl_canceled" )
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
			redirect_to root_path
		end
	end

	#---------- user_check ----------#
	def client_check
		event = Event.find(params[:event_id])
		user = current_user
		cl = user.clients.active.first
		unless user_signed_in? &&( event.client_id == cl.id )
			flash[:alert] = "ログインしてください"
			redirect_to root_path
		end
	end

	def customer_check
		event = Event.find(params[:event_id])
		user = current_user
		cs = user.customers.active.first
		unless user_signed_in? &&( event.customer_id == cs.id)
			flash[:alert] = "ログインしてください"
			redirect_to root_path
		end
	end


end