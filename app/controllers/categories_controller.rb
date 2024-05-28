class CategoriesController < ApplicationController

    # get /categories
    def index
        @categories = Category.all
    end

    def api
        categories = Category.all
        render json: categories
    end

    #update_category - updates a category's parameters, otherwise returning
    # a customised warning text.
    def update_category
        warningwords = ''
        validate_state = true

        category = params[:category]
        id = category[:id]
        name = category[:name]
        purpose = category[:purpose]

        if name  == '' or name.nil?
            warningwords = warningwords + "The category cannot be empty. "
            validate_state = false
        else
        end
        if validate_state == true
            Category.update_category_by_manager(id, name, purpose)
        else
            flash[:warning] = warningwords
        end

        redirect_back(fallback_location: '/home')
    end

    #add_category - Adds a category to the database based on the provided
    #parameters, otherwise returns a custom error text.
    def add_category
        warningwords = ''
        validate_state = true

 
        category = params[:category]
        name = category[:name]
        purpose = category[:purpose]


        if name  == '' or name.nil?
            warningwords = warningwords + "The category cannot be empty. "
            validate_state = false
        else
        end
        if validate_state == true
            Category.create_category(name, purpose)
        else
            flash[:warning] = warningwords
        end


  
    
        redirect_back(fallback_location: '/home')
    end






end