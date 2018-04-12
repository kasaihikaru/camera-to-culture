class EventStatesController < ApplicationController



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

	def cs_complain_1
		EventState.create(event_id: event_id_params, comment: comment_params, state: "cs_complained_1" )
		redirect_to event_path(event_id_params)
	end

	def cs_complain_2
		EventState.create(event_id: event_id_params, comment: comment_params, state: "cs_complained_2" )
		redirect_to event_path(event_id_params)
	end

private
	def comment_params
		params[:comment]
	end

	def event_id_params
		params[:event_id].to_i
	end


end