require 'rails_helper'

RSpec.describe Bug, :type => :model do

    subject { 
         described_class.new(id: 1,
                              title: "Test Bug",
                              description: "This is a test bug", 
                              status: "New",
                              bug_type: "bug",
                              user_id: 1,
                              fixer_id: 5,
                              project_id: 1
         )
    }

  describe "Validations" do
    it "is valid with valid attributes" do
      expect(subject).to be_valid
    end

    it "is not valid without a Title" do
      subject.title = nil
      expect(subject).to_not be_valid
    end

    it "is not valid without a Status" do
      subject.status = nil
      expect(subject).to_not be_valid
    end

    it "is not valid without a Bug type" do
        subject.bug_type = nil
        expect(subject).to_not be_valid
    end

    it "is valid without a Screenshot" do
        subject.screenshot = nil
        expect(subject).to be_valid
    end

    it "is valid without a description" do
        subject.description = nil
        expect(subject).to be_valid
    end

    it "is valid without a deadline" do
        subject.deadline = nil
        expect(subject).to be_valid
    end

  end

  describe "Associations" do
    it { should belong_to(:user).without_validating_presence }
    
    it { should belong_to(:project).without_validating_presence }
  end

end