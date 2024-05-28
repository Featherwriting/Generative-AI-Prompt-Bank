require 'rails_helper'
RSpec.describe CategoriesController, type: :controller do
  
  
  
  describe '#index' do
   it 'assigns all categories to @categories' do
    categories = create_list(:category, 3) 
    controller = CategoriesController.new
    category = controller.index 
    expect(category.length).to eq(categories.length)
   end
  end
  
  describe '#api' do
    it 'returns JSON with all categories' do
      categories = create_list(:category, 3) 

      get :api

      expect(response).to have_http_status(:success)

      json_response = JSON.parse(response.body)
      expect(json_response.size).to eq(categories.size) 

      json_response.each_with_index do |category, index|
        expect(category['id']).to eq(categories[index].id) 
        expect(category['name']).to eq(categories[index].name)
      end
    end
  end

    describe "#update_category" do
      context "when category name exists" do
        it "returns matching categories" do
          category = Category.create(name:"1",purpose:"2")

          post :update_category, params: { category: {id:category.id,name:"11",purpose:"22"}}
          expect(category.reload.name).to eq("11")
          expect(category.reload.purpose).to eq("22")
          expect(response).to redirect_to('/home')
        end
      end
      
        describe "#update_category" do
          context "when category name not exists" do
            it "returns matching categories" do
              category = Category.create(name: nil, purpose: "2")
      
              post :update_category, params: { category: { id:category.id} }
              expect(flash[:warning]).to eq("The category cannot be empty. ")
              expect(response).to redirect_to('/home')
            end
          end
        end
       
       describe "#add_category" do
         context "when category name exists" do
          it "returns matching categories" do
            post :add_category, params: {category: {name:"11",purpose:"22"}}
            expect(Category.last.name).to eq("11")
          end
         end
       end
     
       describe "#add_category" do
       context "when category name exists" do
        it "returns matching categories" do
          post :add_category, params: {category: {name:nil,purpose:"22"}}
          expect(flash[:warning]).to eq("The category cannot be empty. ")
        end
       end
     end

    end
end
  
  