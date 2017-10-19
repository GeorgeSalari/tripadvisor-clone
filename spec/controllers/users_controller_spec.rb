require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:valid_user) {{email:"test3@gmail.com", first_name:"test", last_name:"test", password: "123456"}}
  let(:invalid_user) {{email:"test2@gmail.com", first_name:"test", last_name:"test", password: "123"}}

  context "create" do
    describe "cannot be created without a first name" do
      When(:user) { User.create(
        last_name: "test",
        email: "test@gmail.com",
        password: "123456"
        )}
      Then { user.valid? == false }
    end

    describe "cannot be created without a last name" do
      When(:user) { User.create(
        first_name: "test",
        email: "test@gmail.com",
        password: "123456"
        )}
      Then { user.valid? == false }
    end

    describe "cannot be created without a email" do
      When(:user) { User.create(
        first_name: "test",
        last_name: "test",
        password: "123456"
        )}
      Then { user.valid? == false }
    end


    describe "cannot be created without a password" do
      When(:user) { User.create(
        first_name: "test",
        last_name: "test",
        email: "test@gmail.com"
        )}
      Then { user.valid? == false }
    end

    it "creates new user if params are correct" do
      expect{post :create, params: {user: valid_user}}.to change(User, :count).by(1)
    end

    it "expect to get correct flash" do
      post :create, params: {user: valid_user}
      expect(flash[:notice]).to include 'Hello test'
    end

    it "not creates a user if params are incorrect" do
      expect{post :create, params: {user: invalid_user}}.not_to change(User, :count)
    end

    it "expect to get correct flash" do
      post :create, params: {user: invalid_user}
      expect(flash[:error]).to include 'is too short (minimum is 6 characters)'
    end

    it "redirect to hotel index" do
      post :create, params: {user: invalid_user}
      expect(response).to redirect_to "hotels/index"
    end

  end

end
