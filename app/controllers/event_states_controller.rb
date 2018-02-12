class EventStatesController < ApplicationController
	def new
		@user = current_user
		@cl = @user.clients.active.first
		@cs = @user.customers.active.first
	end

	def create
		
	end
end