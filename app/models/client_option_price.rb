class ClientOptionPrice < ApplicationRecord
	scope :active, -> { where(deleted_at: nil) }

	belongs_to :client

	has_many :event_option_prices

	validates :price, numericality: { only_integer: true, greater_than_or_equal_to: -1000000, less_than_or_equal_to: 1000000 }
end