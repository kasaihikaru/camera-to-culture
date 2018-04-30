class EventPhotosController < ApplicationController
	before_action :user_check, only: [:create, :r_destroy]
	before_action :state_recieved, only: [:zip_dl]

	def create
		EventPhoto.create(create_params)
	end

	def r_destroy
		# 一応、current_userかチェックしてから消去
		for id in params[:delete_ev_photo]
			ev_ph = EventPhoto.find(id)
			if ev_ph.event_id == params[:event_id].to_i
				ev_ph.update(deleted_at: Time.now)
			end
		end

		event = Event.find(params[:event_id])
		redirect_to event_path(event)
	end


	include ActionController::Streaming
	include Zipline
	def zip_dl
		ev_photos = EventPhoto.from_ev(event_id_params).active.image_present
		respond_to do |format|
			format.html
			format.zip do
				files =  ev_photos.map{ |ev_photo| [ev_photo.image, "#{ev_photo.id}.jpg"] }
				zipline(files, 'Camera-to-Culture-Photos_' + Time.now().to_s + '.zip')
			end
		end
	end


#------ストロングパラメーター------#
private
	#---------- params ----------#
	def create_params
		ev_photo = {}
		ev_photo[:image] = params[:event_photo]
		ev_photo[:event_id] = params[:event_id].to_i
		return ev_photo
	end

	def event_id_params
		params[:event_id]
	end

	def r_destroy_params
		params[:delete_ev_photo]
	end

	#---------- user_check ----------#
	def user_check
		unless user_signed_in? && Event.find(params[:event_id]).client == current_user.clients.active.first
			flash[:alert] = "ログインしてください"
			redirect_to root_path
		end
	end

	#---------- state_check ----------#
	def state_recieved
		event = Event.find(params[:event_id].to_i)
		unless event.event_states.last.state == "cs_recieved"
			flash[:alert] = "リクエストが不正です"
			redirect_to root_path
		end
	end

end