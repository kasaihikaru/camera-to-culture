class ClientContact < ApplicationRecord
	validates :tel,
		presence: true,
		format: {with: /\A[0-9-]{,14}\z/},
		length: { in: 10..15 }
	validates :address, presence: true

	scope :active, -> { where(is_deleted: false) }

	belongs_to :client
end