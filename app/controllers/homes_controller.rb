class HomesController < ApplicationController
	def show
		if user_signed_in?
			@user = current_user
			@cl = @user.clients.active.first
			@cs = @user.customers.active.first
		end
	end
end