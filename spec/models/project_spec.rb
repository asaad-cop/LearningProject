require 'rails_helper'

RSpec.describe Project, :type => :model do
  subject { 
         described_class.new(id: 1,
                              title: "Test Project",
                              description: "This is test project"
         )
  }

  describe "Validations" do
    it "is valid with valid attributes" do
      expect(subject).to be_valid
    end

    it "is not valid without a title" do
      subject.title = nil
      expect(subject).to_not be_valid
    end

    it "is valid without a description" do
      subject.description = nil
      expect(subject).to be_valid
    end

  end

  describe "Associations" do
    it { should have_many(:bugs).without_validating_presence }
    
    it { should have_and_belong_to_many(:users).without_validating_presence }
  end

end