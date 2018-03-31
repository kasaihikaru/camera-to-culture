class Prefecture < ApplicationRecord
	has_many :client_locations
	has_many :clients, through: :client_locations
	has_many :events

	#indexでの検索用
  scope :id_in, -> ids {
    where(id: ids) if ids.present?
  }
end