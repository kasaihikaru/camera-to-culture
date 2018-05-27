class HelpsController < ApplicationController
	def To_receive_email
		import_current_user
	end
end