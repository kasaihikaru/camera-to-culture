class ClientOptionPrice < ApplicationRecord
	scope :active, -> { where(deleted_at: nil) }

	belongs_to :client

	has_many :event_option_prices
end