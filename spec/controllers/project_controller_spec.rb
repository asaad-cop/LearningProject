require "rails_helper"

RSpec.describe ProjectsController, type: :controller do

  before(:all) do
    @project = Project.create(title: "Test proj",
    description: "This is a test proj")
  end

  let!(:user) {
  User.create(password: "123456",
                email: "asdtest@gmail.com",
                name: "Dr. Strange",
                user_type: "manager")
  }

  describe "Test CRUD functionality without login" do    
    it "raises an authorization error if tried to access index page" do
        expect {get :index}.to raise_error(CanCan::AccessDenied)
    end
    it "raises an authorization error if tried to create a new project" do
        expect {get :new}.to raise_error(CanCan::AccessDenied)
    end
  end

  describe "Test CRUD functionality after logging in login" do
    before do
      @user = user
      sign_in user
    end

    it "shows the index page of projects" do
      request.headers["Authorization"] = "foo"
      get :index
      expect(response).to have_http_status(:ok)
    end
    
    it "Create a new project" do
      request.headers["Authorization"] = "foo"
      get :new
      expect(response).to have_http_status(:ok) 
    end

    it 'checks that a bug can be updated' do
      @project.update(:title => "Updated title")
      expect(Project.find_by_title("Updated title")).to eq(@project)
    end

    it 'checks that a bug can be destroyed' do
      @project.destroy
      expect(Project.find_by(title: "Updated title")).to be_nil
    end
  end
end