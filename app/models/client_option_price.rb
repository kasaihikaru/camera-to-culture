class ClientOptionPrice < ApplicationRecord
	scope :active, -> { where(is_deleted: false) }

	belongs_to :client

	has_many :event_option_prices
end