class ClientContactsController < ApplicationController
before_action :user_check, only: [:first_new, :new]


#------------- 最初のカメラマン登録 ----------------#
	def first_new
		@user = current_user
		@cl = @user.clients.active.first
		@cs = @user.customers.active.first
		@contact = ClientContact.new
		@pre_cl_contact = @cl.client_contacts.active.first
	end

	def first_create
		@user = current_user
		@cl = @user.clients.active.first
		@cs = @user.customers.active.first

		# 前のレコードを取ってくる
		@pre_cl_contact = @cl.client_contacts.active.first


		@contact = ClientContact.new(create_params)

		# validation後に、create
		if @contact.save

			# 前のレコードを消す
			if @pre_cl_contact.present?
				@pre_cl_contact.update(is_deleted: true)
			end

			#同意
			@cl.update(consent: true)

			redirect_to edit_user_client_path(@user, @cl)

		# validationにひっかかったら、エラーメッセージ表示
		else
			render action: :new
		end

	end



#------------- 住所、電話番号変更 ----------------#
	def new
		@user = current_user
		@cl = @user.clients.active.first
		@cs = @user.customers.active.first
		@contact = ClientContact.new
		@pre_cl_contact = @cl.client_contacts.active.first
	end

	def create
		@user = current_user
		@cl = @user.clients.active.first
		@cs = @user.customers.active.first

		# 前のレコードを取ってくる
		@pre_cl_contact = @cl.client_contacts.active.first


		@contact = ClientContact.new(create_params)

		# validation後に、create
		if @contact.save

			# 前のレコードを消す
			if @pre_cl_contact.present?
				@pre_cl_contact.update(is_deleted: true)
			end

			flash[:alert] = "更新しました"
			redirect_to new_user_client_client_contact_path(@user, @cl)

		# validationにひっかかったら、エラーメッセージ表示
		else
			render action: :new
		end
	end



private
	def create_params
		params.require(:client_contact).permit(:tel, :address).merge(client_id: params[:client_id])
	end

	def user_check
		unless user_signed_in? && params[:user_id].to_i == current_user.id && Client.find(params[:client_id]).user == current_user
			flash[:alert] = "ログインしてください"
			redirect_to root_path
		end
	end
end