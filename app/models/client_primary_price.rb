class ClientPrimaryPrice < ApplicationRecord
	scope :active, -> { where(is_deleted: false) }

	belongs_to :client

	has_many :event_primary_prices
end