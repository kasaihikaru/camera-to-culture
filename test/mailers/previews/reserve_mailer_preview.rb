# Preview all emails at http://localhost:3000/rails/mailers/reserve_mailer
class ReserveMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/reserve_mailer/cs_requested
  def cs_requested
    ReserveMailer.cs_requested
  end

end
