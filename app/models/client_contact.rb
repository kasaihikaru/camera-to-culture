class ClientContact < ApplicationRecord
	validates :tel,
		presence: true,
		format: {with: /\A[0-9-]{,14}\z/},
		length: { in: 10..15 }
	validates :address, presence: true
	validates :name, presence: true

	scope :active, -> { where(deleted_at: nil) }

	belongs_to :client
end