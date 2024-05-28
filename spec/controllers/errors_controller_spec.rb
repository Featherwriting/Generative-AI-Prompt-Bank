require 'rails_helper'

RSpec.describe ErrorsController, type: :controller do
  describe "#show" do
    context "when rendering error page" do
      it "renders the appropriate HTTP status code page" do
        { "404" => 404, "422" => 422, "500" => 500 }.each do |code, status|
          get :show, params: { code: code }
          expect(response).to have_http_status(status)
          expect(response).to render_template(status.to_s)
        end
      end
    end
  end
end
