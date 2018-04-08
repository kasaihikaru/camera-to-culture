class Event < ApplicationRecord
	belongs_to :customer
	belongs_to :client
	belongs_to :prefecture

	has_many :event_categories
	has_many :event_primary_prices
	has_many :event_option_prices
	accepts_nested_attributes_for :event_option_prices
	has_many :event_photos
	has_many :event_states
	has_many :client_reviews
	has_many :customer_reviews

  # def self.as_cl(client_id)
  #   where(client_id: client_id)
  # end
	scope :as_cl, -> client_id{ where(client_id: client_id) }
	scope :as_cs, -> customer_id{ where(customer_id: customer_id) }
	scope :request, ->  {
		joins(:event_states).merge(EventState.request)
	}
	scope :future, ->  { where("start_time > ?", Time.now())}
	scope :past, ->  { where("start_time <= ?", Time.now())}
end