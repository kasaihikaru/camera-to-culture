class ClientSchedule < ApplicationRecord
	belongs_to :client

	scope :future, ->  { where("date > ?", Date.today())}
	scope :past, ->  { where("date <= ?", Date.today())}
	scope :available, ->  { where.not(schedule: "")}
end