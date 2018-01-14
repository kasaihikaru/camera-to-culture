class Category < ApplicationRecord
	has_many :client_categories
	has_many :event_categories
	has_many :clients, through: :client_categories

	#indexでの検索用
  scope :id_in, -> ids {
    where(id: ids) if ids.present?
  }

end