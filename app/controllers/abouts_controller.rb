class AboutsController < ApplicationController
	def show
		import_current_user
	end

	def terms_of_service_cl
		import_current_user
	end

	def terms_of_service_cs
		import_current_user
	end

	def to_be_a_cameraman
		import_current_user
	end

	def how_to_use
		import_current_user
	end

	def use_with_phone
		import_current_user
	end

	def contact_us
		import_current_user
	end

end