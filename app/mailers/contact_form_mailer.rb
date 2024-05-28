class ContactFormMailer < ApplicationMailer
  default from: '<no-reply@sheffield.ac.uk>'
  def send_contact_email(email, message)
    @message = message
    mail(to: '301@sheffield.ac.uk', subject: 'Contact')
  end
end