require "rails_helper"

RSpec.describe PagesController, type: :controller do

  describe "Testing pages controller" do
    it "shows home page" do
      request.headers["Authorization"] = "foo"
      get :home
      expect(response).to have_http_status(:ok)
    end

    it "shows users page" do
        request.headers["Authorization"] = "foo"
        get :users
        expect(response).to have_http_status(:ok)
    end
  end
end