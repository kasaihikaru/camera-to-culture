class EventState < ApplicationRecord
	belongs_to :event

	scope :request, -> { where(state: "request") }
	scope :cl_edited, -> { where(state: "cl_edited") }
	scope :accepted, -> { where(state: ["cl_accepted", "cs_accepted"])}
	scope :cl_delivered, -> { where(state: "cl_delivered") }
end