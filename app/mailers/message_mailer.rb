class MessageMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.message_mailer.recieved.subject
  #
  def recieved(message, mail, name)
    @message = message
    @mail = mail
    @name = name

    mail(
      # TOは単体のメールアドレスでもArrayのメールアドレスでも大丈夫
      to: @mail,
      subject: t(".ctoc") + @name + t(".title"),
    )
  end
end