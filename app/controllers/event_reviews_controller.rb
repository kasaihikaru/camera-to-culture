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
		score = params[:score]
		unless score == nil
			score = score.to_i.round
			if score < 1
				score == 1
			elsif score > 5
				score == 5
			else
				score = score
			end
			params.require(:event_review).permit(:cl_review, :cs_review, :cl_comment, :cs_image_1, :cs_image_2, :cs_image_3, :cs_image_4, :cs_image_5, :cs_image_6).merge(event_id: params[:event_id], stars: score)
		else
			params.require(:event_review).permit(:cl_review, :cs_review, :cl_comment, :cs_image_1, :cs_image_2, :cs_image_3, :cs_image_4, :cs_image_5, :cs_image_6).merge(event_id: params[:event_id])
		end
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
