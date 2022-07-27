require "rails_helper"

RSpec.describe BugsController, type: :controller do
  before(:all) do
    @bug = Bug.create(title: "Test Bug",
    description: "This is a test bug", 
    status: "New",
    bug_type: "bug",
    fixer_id: 1)
  end

  let!(:user) {
  User.create(password: "123456",
                email: "asdtest@gmail.com",
                name: "Dr. Strange",
                user_type: "manager")
  }

  let!(:project) {
  Project.create(title: "test proj",
                  description: "this is test project")
  }

  describe "Test without login" do

    it "raises an authorization error if tried to access index page" do
      expect {get :index}.to raise_error(CanCan::AccessDenied)
    end    
      
    it "raises an authorization error if tried to create a new bug" do
      expect {get :new}.to raise_error(CanCan::AccessDenied)
    end
  end

  describe "Test CRUD functionality after logging in" do
    before do
      @user = user
      sign_in user
    end
    it "shows the index page of bugs" do
      request.headers["Authorization"] = "foo"
      get :index
      expect(response).to have_http_status(:ok)
    end
    
    it "Create a new bug" do
      request.headers["Authorization"] = "foo"
      get :new
      expect(response).to have_http_status(:ok) 
    end

    it 'checks that a bug can be updated' do
      @bug.update(:title => "Updated title")
      expect(Bug.find_by_title("Updated title")).to eq(@bug)
    end

    it 'checks that a bug can be destroyed' do
      @bug.destroy
      expect(Bug.find_by(title: "Updated title")).to be_nil
    end

  end
end