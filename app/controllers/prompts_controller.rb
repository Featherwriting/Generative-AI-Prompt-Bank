class PromptsController < ApplicationController

    def api
        prompts = Prompt.all.order(:id)
        prompts_as_json = prompts.as_json(include: [:issues, :examples, :tags])
        render json: prompts_as_json
    end
      
   
    #delete_prompt - deletes the prompt id
    #parameters - id - a prompt id
    def delete_prompt
        id = params[:id]
        prompt = Prompt.find_by(id:id)
        if prompt.nil?
        else
            prompt.delete
        end
        redirect_back(fallback_location: '/home')
    end

    #submit_prompt - submits a prompt to the db
    # parameters - form - the prompt info from the submitted form
    def submit_prompt

        warningwords = ''
        validate_state = true

        #collect data from submit form
        form = params[:prompt]
        prompt_content = form[:text]
        email_address = form[:email]
        category_id = form[:category]
        tags = form[:tag]
        issues = form[:issue]
        examples = form[:link]

        warningwords,validate_state = valid_prompt(email_address,prompt_content,category_id)
        #create prompt if all check passed or show the warning feedback

        if validate_state == true
            Prompt.create_prompts_by_user(prompt_content,email_address,category_id,tags,issues,examples)
        else
            flash[:warning] = warningwords
        end

        redirect_back(fallback_location: '/home')
    end


    #submit_prompt_visible - creates a visible prompt from the supplied parameters.
    # Called on the manage page to update prompts
    def submit_prompt_visible
        warningwords = ''
        validate_state = true
    
        form = params[:prompt]
        prompt_id = form[:id]
        category_id = form[:category]
        tags = form[:tag]
        issues = form[:issue]
        examples = form[:link]
        prompt_content = form[:text]
        stat = form[:stat]
        use_count = form[:use_count]
        if prompt_content == '' or prompt_content.nil?
            warningwords = warningwords + "The prompt content cannot be empty. "
            validate_state = false
        else
        end

        #check if the category id has been chosen
        if Category.find_by(id: (category_id).to_i).nil?
            warningwords = warningwords + "The Category ID should be chosen. "
            validate_state = false
        else
        end
        if validate_state == true
            Prompt.update_prompts_by_user(prompt_id,prompt_content,category_id,tags,issues,examples,stat,use_count)
        else
            flash[:warning] = warningwords
        end
    
        redirect_back(fallback_location: '/home')
    end
    #approve_prompt - approves a pending prompt, and sends a confirmation email to the user who submitted it
    def approve_prompt
        warningwords = ''
        validate_state = true
        
        #set up prompt data from parameters
        form = params[:prompt]
        prompt_id = form[:id]
        email = form[:email]
        category_id = form[:category]
        tags = form[:tag]
        issues = form[:issue]
        examples = form[:link]
        prompt_content = form[:text]
        stat = form[:stat]
        use_count = form[:use_count]

        #warn if invalid
        if prompt_content == '' or prompt_content.nil?
            warningwords = warningwords + "The prompt content cannot be empty. "
            validate_state = false
        else
        end

        #check if the category id has been chosen
        if Category.find_by(id: (category_id).to_i).nil?
            warningwords = warningwords + "The Category ID should be chosen. "
            validate_state = false
        else
        end

        if validate_state == true
            Prompt.update_prompts_by_user(prompt_id,prompt_content,category_id,tags,issues,examples,stat,use_count)
        else #catch potential errors if category ID not set
            flash[:warning] = warningwords
        end
        
        UserMailer.new_approve_email(email).deliver_now
    
        redirect_back(fallback_location: '/home')
    end
    #reject_prompt - rejects the prompt passed in, sending an email to the relevant user and deleting the prompt
    def reject_prompt
        form = params[:prompt]
        prompt_id = form[:id]
        submitter_email = form[:email]
        reason = form[:reason] 
        
        prompt = Prompt.find(prompt_id)
        prompt.delete

        UserMailer.new_decline_email(submitter_email, reason).deliver_now

        redirect_back(fallback_location: '/home')
    end

    #increase_clicks - increases the use count of the prompt id passed in by 1.
    def increase_clicks
        ids = params[:id]
        ids.each do |id|
            prompt = Prompt.find(id)
            prompt.update(use_count: prompt.use_count + 1)
        end
        render plain: '', status: :ok
    end



    #decrease_use_count - decreases the use count of the prompt id passed in by 1.
    def decrease_use_count
        id = params[:id]
        @prompt = Prompt.find(id)
        @prompt.decrease_use_count(@prompt.use_count - 2000)
        render plain: '', status: :ok
    end

    def increase_use_count
        id = params[:id]
        @prompt = Prompt.find(id)
        @prompt.increase_use_count()
        render plain: '', status: :ok
    end

    #valid_prompt - validates the email, prompt text and category passed in to verify a submitted prompt,
    # otherwise, the user is warned.
    def valid_prompt(email_address,prompt_content,category_id)
        warningwords = ''
        validate_state = true
        #check if the email is right
        if !User.varify_account_nil(email_address)
        else
            warningwords = warningwords + "The email address is not valid or is not a sheffiled university email address. "
            validate_state = false
        end

        #check if the prompt content is valid
        if prompt_content == '' or prompt_content.nil?
            warningwords = warningwords + "The prompt content cannot be empty. "
            validate_state = false
        else
        end

        #check if the category id has been chosen
        if Category.find_by(id: (category_id).to_i).nil?
            warningwords = warningwords + "The Category ID should be chosen. "
            validate_state = false
        else
        end

        return [warningwords,validate_state]
    end


  end
  