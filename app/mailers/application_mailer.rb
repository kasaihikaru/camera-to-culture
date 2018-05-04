class ApplicationMailer < ActionMailer::Base
  default from: ENV['ctoc_mail_user_name']
  layout 'mailer'
end
