class Customer < ApplicationRecord

	scope :active, -> { where(deleted_at: nil) }

	belongs_to :user

	has_many :events
	has_many :client_reviews
	has_many :customer_reviews

	validates :introduction, length: { maximum: 120 }

	def soft_delete
		update(deleted_at: Time.now)
	end

end