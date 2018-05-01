class HomesController < ApplicationController
	def show
		if user_signed_in?
			@user = current_user
			@cl = @user.client
			@cs = @user.customer
		end
	end
end