require 'rails_helper'

RSpec.describe User, :type => :model do
  subject { 
         described_class.new(id: 1,
                              name: "john",
                              password: "123456", 
                              email: "xyz@gmail.com",
                              user_type: "manager"
         )
  }

  describe "Validations" do
    it "is valid with valid attributes" do
      expect(subject).to be_valid
    end

    it "is not valid without a name" do
      subject.name = nil
      expect(subject).to_not be_valid
    end

    it "is not valid without a password" do
      subject.password = nil
      expect(subject).to_not be_valid
    end

    it "is not valid without an email" do
      subject.email = nil
      expect(subject).to_not be_valid
    end
  end

  describe "Associations" do
    it { should have_many(:bugs).without_validating_presence }

    it { should have_and_belong_to_many(:projects).without_validating_presence }
  end

end