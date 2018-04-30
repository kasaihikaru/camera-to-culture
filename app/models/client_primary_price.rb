class ClientPrimaryPrice < ApplicationRecord
	scope :active, -> { where(deleted_at: nil) }

	belongs_to :client

	has_many :event_primary_prices
end