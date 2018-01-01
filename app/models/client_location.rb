class ClientLocation < ApplicationRecord
	belongs_to :country
	belongs_to :prefecture
end
