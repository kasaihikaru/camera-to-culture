class ClientPrimaryPrice < ApplicationRecord
	scope :active, -> { where(deleted_at: nil) }

	belongs_to :client

	has_many :event_primary_prices

	validates :price_per_hour, numericality: { only_integer: true, greater_than_or_equal_to: 500, less_than_or_equal_to: 1000000 }
	validates :minimum_hours, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 23 }

end