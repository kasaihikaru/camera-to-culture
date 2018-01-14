class Prefecture < ApplicationRecord
	has_many :client_locations
	has_many :clients, through: :client_locations

	#indexでの検索用
  scope :id_is, -> id {
    where(id: id)
  }
end