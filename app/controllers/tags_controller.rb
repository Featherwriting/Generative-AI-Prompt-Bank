class TagsController < ApplicationController

    def index
        @tags = Tag.all
    end

    def api
        tags = Tag.all
        render json: tags
    end
    
    
    #update_tag - updates or deletes a tag based on specified action and parameters.
    #Updating tag parameters is validated and can send alerts with feedback.
    def update_tag
        warningwords = ''
        validate_state = true
        tag = params[:tag]
        id = tag[:id]
        name = tag[:name]
        #edit tag
        if tag[:action] == 'edit'
            if name  == '' or name.nil?
                warningwords = warningwords + "The tag cannot be empty. "
                validate_state = false
            else
            end
            #if tag is valid, then update
            if validate_state == true
                Tag.update_tag_by_manager(id, name)
            else
                flash[:warning] = warningwords
            end
        elsif tag[:action] == 'delete'
            #delete tag
            Tag.destroy_by(id: id)
        end
        redirect_back(fallback_location: '/home')
    end

    # add_tag - adds a tag to the db based on the provided parameters, otherwise returning an error
    def add_tag
        warningwords = ''
        validate_state = true

        tag = params[:tag]
        name = tag[:name]

        if name  == '' or name.nil?
            warningwords = warningwords + "The tag cannot be empty. "
            validate_state = false
        else
        end
        #create tag if it is valid
        if validate_state == true
            Tag.create_tag(name)
        else
            #show error
            flash[:warning] = warningwords
        end

        #redirect
        redirect_back(fallback_location: '/home')
    end 
end
