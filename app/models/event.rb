class Event < ApplicationRecord
	belongs_to :customer
	belongs_to :client

	has_many :event_categories
	has_many :event_primary_price
	has_many :event_option_prices
	accepts_nested_attributes_for :event_option_prices
	has_many :event_photos
	has_many :event_states
	has_many :client_reviews
	has_many :customer_reviews
end