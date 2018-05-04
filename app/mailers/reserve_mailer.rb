class ReserveMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.reserve_mailer.cs_requested.subject
  #
  def cs_requested
    @greeting = "Hi"

    mail to: "to@example.org"
  end
end
