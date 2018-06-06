class ClientConsentMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.client_consent_mailer.first_new.subject
  #
	def first_create(id, name, mail, created_at, consented_at, tel, address, real_name, line_id, wechat_id)
		@id = id
		@name = name
		@mail = mail
		@created_at = created_at
		@consented_at = consented_at
		@tel = tel
		@address = address
		@real_name = real_name
		@line_id = line_id
		@wechat_id = wechat_id

		mail(
			to: ENV['myaddress'],
			subject: '【CtoC】' + @name + 'さんがカメラマン登録',
		)
	end

end
