class HelpsController < ApplicationController
	def to_receive_email
		import_current_user
	end
end