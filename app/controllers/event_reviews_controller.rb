class EventReviewsController < ApplicationController
	def create
		EventReview.create(create_params)
	end

	def update
		ev_rev = EventReview.find(id_params)
		ev_rev.update(create_params)
	end

private
	def create_params
		 params.require(:event_review).permit(:cl_review).merge(event_id: params[:event_id])
	end

	def update_params
		 params.require(:event_review).permit(:cl_review).merge(event_id: params[:event_id])
	end

	def id_params
		params[:id]
	end
end
