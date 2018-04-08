class EventStatesController < ApplicationController



	def cl_accept
		EventState.create(event_id: event_id_params, comment: comment_params, state: "cl_accepted" )
		redirect_to event_path(event_id_params)
	end

	def cs_open_for_dl
		EventState.create(event_id: event_id_params, comment: comment_params, state: "cs_opened" )
		redirect_to event_path(event_id_params)
	end

	def cs_claim
		
	end

	def cl_deliver

	end


	def cs_recieved

	end


	def cl_edit

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

private
	def comment_params
		params[:comment]
	end

	def event_id_params
		params[:event_id].to_i
	end


end