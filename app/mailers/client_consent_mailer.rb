class ClientConsentMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.client_consent_mailer.first_new.subject
  #
	def first_create(name, mail, created_at, consented_at, tel, address)
		@name = name
		@mail = mail
		@created_at = created_at
		@consented_at = consented_at
		@tel = tel
		@address = address

		mail(
			to: ENV['myaddress'],
			subject: '【CtoC】' + @name + 'さんがカメラマン登録',
		)
	end

end
