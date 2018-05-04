# Preview all emails at http://localhost:3000/rails/mailers/client_consent_mailer
class ClientConsentMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/client_consent_mailer/first_new
  def first_new
    ClientConsentMailer.first_new
  end

end
