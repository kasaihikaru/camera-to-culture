class Client < ApplicationRecord

	scope :active, -> { where(is_deleted: false) }

	belongs_to :user

	has_many :client_portfolios
	accepts_nested_attributes_for :client_portfolios
	has_many :client_locations
	has_many :client_categories
	has_many :client_schedules
	has_many :client_primary_prices
	has_many :client_option_prices
	has_many :messages
	has_many :events
	has_many :client_reviews
	has_many :customer_reviews
end