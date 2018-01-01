class EventOptionPrice < ApplicationRecord
	belongs_to :event
	belongs_to :client_option_price
end