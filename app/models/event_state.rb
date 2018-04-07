class EventState < ApplicationRecord
	belongs_to :event

	scope :request, -> { where(state: "request") }
end