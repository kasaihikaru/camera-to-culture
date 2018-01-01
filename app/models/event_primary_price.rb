class EventPrimaryPrice < ApplicationRecord
	belongs_to :event
	belongs_to :client_primary_price
end