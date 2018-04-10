class EventPhotosController < ApplicationController
before_action :user_check, only: [:create, :r_destroy]

	def create
		EventPhoto.create(create_params)
	end

	def r_destroy
		# 一応、current_userかチェックしてから消去
		for id in params[:delete_ev_photo]
			ev_ph = EventPhoto.find(id)
			if ev_ph.event_id == params[:event_id].to_i
				ev_ph.update(is_deleted: true)
			end
		end

		event = Event.find(params[:event_id])
		redirect_to event_path(event)
	end


#------ストロングパラメーター------#
private
	def create_params
		ev_photo = {}
		ev_photo[:image] = params[:event_photo]
		ev_photo[:event_id] = params[:event_id].to_i
		return ev_photo
	end



	def r_destroy_params
		params[:delete_ev_photo]
	end

	def user_check
		unless user_signed_in? && Event.find(params[:event_id]).client == current_user.clients.active.first
			flash[:alert] = "ログインしてください"
			redirect_to root_path
		end
	end

end