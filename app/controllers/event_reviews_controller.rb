class EventReviewsController < ApplicationController
	def create
		EventReview.create(create_params)
		redirect_to event_path(event_id_params)
	end

	def update
		ev_rev = EventReview.find(id_params)
		ev_rev.update(create_params)
		redirect_to event_path(event_id_params)
	end

private
	def create_params
		 params.require(:event_review).permit(:cl_review, :cs_review, :cl_comment).merge(event_id: params[:event_id])
	end

	def update_params
		 params.require(:event_review).permit(:cl_review, :cs_review).merge(event_id: params[:event_id])
	end

	def id_params
		params[:id]
	end

	def event_id_params
		params[:event_id].to_i
	end
end
