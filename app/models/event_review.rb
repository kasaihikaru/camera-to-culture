class EventReview < ApplicationRecord

	belongs_to :event

	scope :cs_reviewed, -> { where.not(cs_review: nil) }

end