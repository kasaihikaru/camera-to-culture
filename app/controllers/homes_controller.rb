class HomesController < ApplicationController
	def show
		import_current_user
	end
end