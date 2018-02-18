class AboutsController < ApplicationController
	def show
		if user_signed_in?
			@user = current_user
			@cl = @user.clients.active.first
			@cs = @user.customers.active.first
		end
	end

	def terms_of_service_cl
		if user_signed_in?
			@user = current_user
			@cl = @user.clients.active.first
			@cs = @user.customers.active.first
		end
	end

	def terms_of_service_cs
		if user_signed_in?
			@user = current_user
			@cl = @user.clients.active.first
			@cs = @user.customers.active.first
		end
	end

	def to_be_a_cameraman
		if user_signed_in?
			@user = current_user
			@cl = @user.clients.active.first
			@cs = @user.customers.active.first
		end
	end

	def how_to_use
		if user_signed_in?
			@user = current_user
			@cl = @user.clients.active.first
			@cs = @user.customers.active.first
		end
	end

	def use_with_phone
		if user_signed_in?
			@user = current_user
			@cl = @user.clients.active.first
			@cs = @user.customers.active.first
		end
	end


end