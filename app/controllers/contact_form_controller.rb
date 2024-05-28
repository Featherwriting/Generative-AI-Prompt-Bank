class ContactFormController < ApplicationController
    def create
        #creates a new contact_form object
        @email = params[:contact_form][:email]
        @message = params[:contact_form][:message]
        # Perform any necessary actions with the form data
    end

    #submit_contact - Sends a contact form mailer to the admin,
    # otherwise, returns a custom warning message.
    def submit_contact

        warningwords = ''
        validate_state = true
        
        #gets the email and message from the contact form
        email = params[:contact_form][:email]
        message = params[:contact_form][:message]
        
        #validates the messages, if valid sends form.
        warningwords,validate_state = valid_contact(email,message)
        if validate_state
            ContactFormMailer.send_contact_email(email, message).deliver_now
            flash[:success] = "Your message has been sent successfully."
        else
            flash[:warning] = warningwords
        end

        redirect_to :contact
    end
    #valid_email - validates an email against a regex
    #the regex format is:
    #symbols, numbers, or punctuation@symbols, numbers, or punctuation . letters 
    def valid_email?(email)
        # Regular expression for basic email format validation
        email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
        email =~ email_regex
    end
    
    #valid_contact - checks if the provided email and message are valid, returning
    # a warning if not
    def valid_contact(email,message)
        warningwords = ''
        validate_state = true
        #check if the email is right
        if valid_email?(email)
        else
            warningwords = warningwords + "The email address is not valid. "
            validate_state = false
        end

        #check if the message is not empty
        if message == '' or message.nil?
            warningwords = warningwords + "The message cannot be empty. "
            validate_state = false
        else
        end

        return [warningwords,validate_state]
    end
end
