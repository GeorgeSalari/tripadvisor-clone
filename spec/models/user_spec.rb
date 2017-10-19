require 'rails_helper'

RSpec.describe User, type: :model do

  context "validations" do

    it "should have first name, last name, role email and password_digest" do
      should have_db_column(:first_name).of_type(:string)
      should have_db_column(:email).of_type(:string)
      should have_db_column(:password_digest).of_type(:string)
      should have_db_column(:last_name).of_type(:string)
      should have_db_column(:role).of_type(:integer)
    end

    describe "validates presence and uniqueness of first name, last name and email" do
      it { is_expected.to validate_presence_of(:email) }
      it { is_expected.to validate_presence_of(:first_name) }
      it { is_expected.to validate_presence_of(:last_name) }
      it { is_expected.to validate_uniqueness_of(:email) }
    end

    describe "validates password" do
      it { is_expected.to validate_presence_of(:password) }
      it { is_expected.to validate_length_of(:password).is_at_least(6) }
    end

    describe "should permit valid email only" do
      let(:user1) { User.create(first_name: "test", last_name: "test", email: "test4@gmail.com", password: "123456")}
      let(:user2) { User.create(first_name: "test", last_name: "test", email: "test.com", password: "123456") }

      it "sign up with valid email" do
        expect(user1).to be_valid
      end

      it "sign up with invalid email" do
        expect(user2).to be_invalid
      end
    end
  end

  context "asociations" do
    describe "user can have many hotels" do
      it { is_expected.to have_many(:hotels).dependent(:destroy)}
    end
  end

  context "methods" do
    let (:user) { User.new(first_name:"test", last_name:"test1", email:"test@gmail.com", password: "123456")}

    it "should capitalize the users first name and last name" do
      user.capitalize_name
      user.save
      expect(user.first_name).to eq("Test")
      expect(user.last_name).to eq("Test1")
    end

    it "return user's full name" do
      user.save
      expect(user.full_name).to eq("test test1")
    end
  end
end
