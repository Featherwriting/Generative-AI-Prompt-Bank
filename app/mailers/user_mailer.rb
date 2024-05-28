class UserMailer < ApplicationMailer
    default from: '<no-reply@sheffield.ac.uk>'
    def new_approve_email(email)
        mail(to: email, subject: 'Prompt Approve')
    end
    def new_decline_email(email, reason)
        @reason = reason
        mail(to: email, subject: 'Prompt Decline')
    end
end
