class Category < ApplicationRecord
	has_many :client_categories
	has_many :event_categories
end