class ClientOptionPrice < ApplicationRecord
	belongs_to :client

	has_many :event_option_prices
end