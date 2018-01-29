class Customer < ApplicationRecord

	scope :active, -> { where(is_deleted: false) }

	belongs_to :user

	has_many :events
	has_many :client_reviews
	has_many :customer_reviews
end