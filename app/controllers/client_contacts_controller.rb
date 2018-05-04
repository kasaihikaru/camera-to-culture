class ClientContactsController < ApplicationController
	before_action :user_check, only: [:first_new, :new]
	before_action :consent_check, only: :new
	before_action :not_consent_check, only: :first_new


#------------- 最初のカメラマン登録 ----------------#
	def first_new
		@user = current_user
		@cl = @user.client
		@cs = @user.customer
		@contact = ClientContact.new
		@pre_cl_contact = @cl.client_contacts.active.first
	end

	def first_create
		@user = current_user
		@cl = @user.client
		@cs = @user.customer

		# 前のレコードを取ってくる
		@pre_cl_contact = @cl.client_contacts.active.first


		@contact = ClientContact.new(create_params)

		# validation後に、create
		if @contact.save

			# 前のレコードを消す
			if @pre_cl_contact.present?
				@pre_cl_contact.update(deleted_at: Time.now)
			end

			#同意
			@cl.update(consent: true)

			# 通知メール
			id = @user.id
			name = @user.name
			mail = @user.email
			created_at = @user.created_at
			consented_at = @contact.created_at
			tel = @contact.tel
			address = @contact.address
			ClientConsentMailer.first_create(id, name, mail, created_at, consented_at, tel, address).deliver_now

			redirect_to edit_user_client_path(@user, @cl)

		# validationにひっかかったら、エラーメッセージ表示
		else
			render action: :new
		end
	end



#------------- 住所、電話番号変更 ----------------#
	def new
		@user = current_user
		@cl = @user.client
		@cs = @user.customer
		@contact = ClientContact.new
		@pre_cl_contact = @cl.client_contacts.active.first
	end

	def create
		@user = current_user
		@cl = @user.client
		@cs = @user.customer

		# 前のレコードを取ってくる
		@pre_cl_contact = @cl.client_contacts.active.first


		@contact = ClientContact.new(create_params)

		# validation後に、create
		if @contact.save

			# 前のレコードを消す
			if @pre_cl_contact.present?
				@pre_cl_contact.update(deleted_at: Time.now)
			end

			flash[:alert] = t(".Setting_has_updated")
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
			flash[:alert] = t(".Please_login")
			redirect_to root_path
		end
	end

	def consent_check
		cl = Client.find(params[:client_id])
		unless cl.consent == true && cl.deleted_at == nil
			flash[:alert] = "指定したページはありません"
			redirect_to root_path
		end
	end

	def not_consent_check
		cl = Client.find(params[:client_id])
		unless cl.consent == false
			flash[:alert] = "指定したページはありません"
			redirect_to root_path
		end
	end
end
