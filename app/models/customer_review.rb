class CustomerReview < ApplicationRecord
	belongs_to :customer
	belongs_to :client
	belongs_to :event
end