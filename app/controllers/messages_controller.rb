class MessagesController < ApplicationController
	before_action :user_check, only: [:index, :show]
	before_action :login_check, only: [:new]

	def new
		@msg = Message.new
		@reciever = User.find(user_params)
	end

	def first_create
		Message.create(first_create_params)
		redirect_to user_path(current_user)
	end

	def index
		#-------- left-menu --------#
		@msges = Message.user_sends(current_user.id).or(Message.user_recirves(current_user.id)).order_new

		ids = []
		for ms in @msges
			ids << ms.sender_id
			ids << ms.reciever_id
		end
		user_ids = ids.uniq
		user_ids.delete(current_user.id)
		@users = User.where(id: user_ids).order(['field(id, ?)', user_ids])
	end

	def show
		#-------- left-menu --------#
		@msges = Message.user_sends(current_user.id).or(Message.user_recirves(current_user.id)).order_new

		ids = []
		for ms in @msges
			ids << ms.sender_id
			ids << ms.reciever_id
		end
		user_ids = ids.uniq
		user_ids.delete(current_user.id)
		@users = User.where(id: user_ids).order(['field(id, ?)', user_ids])


		#-------- right-content --------#
		# user
		@comunitating_user = User.find(id_params)
		@cs = @comunitating_user.customers.active.first
		@cl = @comunitating_user.clients.active.first
		@categories = @cl.client_categories.includes(:category)
		@locations = @cl.client_locations.includes(:prefecture)
		@prim_price = @cl.client_primary_prices.active.first
		@options = @cl.client_option_prices.active

		#messages
		@selected_msges = Message.user_sends(current_user.id).user_recirves(id_params).or(Message.user_recirves(current_user.id).user_sends(id_params)).order_new

		# form用
		@msg = Message.new
	end

	def create
		Message.create(create_params)
		redirect_to user_message_path(current_user.id, reciever_params)
	end


private
	def user_params
		params[:user_id]
	end

	def id_params
		params[:id]
	end

	def reciever_params
		params[:message][:reciever_id]
	end

	def first_create_params
		params.require(:message).permit(:message).merge(sender_id: current_user.id, reciever_id: params[:user_id])
	end

	def create_params
		params.require(:message).permit(:message, :reciever_id).merge(sender_id: current_user.id)
	end


	def user_check
		unless user_signed_in? && params[:user_id].to_i == current_user.id
			flash[:alert] = "ログインしてください"
			redirect_to root_path
		end
	end

	def login_check
		unless user_signed_in?
			flash[:alert] = "ログインしてください"
			redirect_to root_path
		end
	end
end