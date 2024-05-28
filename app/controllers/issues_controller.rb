class IssuesController < ApplicationController
    
    def index
        @issues = Issue.all
    end

    def api
        issues = Issue.all
        render json: issues
    end
    
    #update_issue - updates an issue's parameters, otherwise returning
    # a customised warning text.
    def update_issue
        warningwords = ''
        validate_state = true
        #collect data from submit form
        issue = params[:issue]
        id = issue[:id]
        name = issue[:name]
        link = issue[:link]
        if issue[:action] == 'edit'
            if name  == '' or name.nil? or link == '' or link.nil?
                warningwords = warningwords + "The issue cannot be empty. "
                validate_state = false
            else
            end
            if validate_state == true
                Issue.update_issue_by_manager(id, link, name)
            else
                flash[:warning] = warningwords
            end
        elsif issue[:action] == 'delete'
            Issue.destroy_by(id: id)
        end

        redirect_back(fallback_location: '/home')
    end

    def add_issue
        warningwords = ''
        validate_state = true
        
        #collect data from submit form
        issue = params[:issue]
        name = issue[:name]
        link = issue[:link]

        if name  == '' or name.nil? or link == '' or link.nil?
            warningwords = warningwords + "The issue cannot be empty. "
            validate_state = false
        else
        end
        if validate_state == true
            Issue.create_issue(link, name)
        else
            flash[:warning] = warningwords
        end

        redirect_back(fallback_location: '/home')
    end




end
