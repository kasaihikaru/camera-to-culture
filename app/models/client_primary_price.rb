class ClientPrimaryPrice < ApplicationRecord
	belongs_to :client

	has_many :event_primary_prices
end