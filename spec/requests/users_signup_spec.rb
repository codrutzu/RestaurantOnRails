require 'rails_helper'

RSpec.describe "Signup", type: :request do

  before do 
    ActionMailer::Base.deliveries.clear
  end

  describe "signup" do
    it "should be valid with account activation" do
      get signup_path
      expect do
        post users_path, params: { user: 
          { 
            name: "Example User", 
            email: "user@example.com", 
            password: "password", 
            password_confirmation: "password" 
          }}
      end.to change{ User.count }
      expect(ActionMailer::Base.deliveries.size).to eq(1)
      user = assigns(:user)
      expect(user.activated?).to be(false)
      log_in_as(user)
      expect(is_logged_in?).to be(false)
      get edit_account_activation_path("invalid token", email: user.email)
      expect(is_logged_in?).to be(false)
      get edit_account_activation_path(user.activation_token, email: "wrong")
      expect(is_logged_in?).to be(false)
      get edit_account_activation_path(user.activation_token, email: user.email)
      expect(user.reload.activated?).to be(true)
      follow_redirect!
      expect(response).to render_template('users/show')
    end

    it "shouldn't be valid" do
      get signup_path
      expect do
        post users_path, params: { user: 
        {
          name: "",
          email: "user@invalid", 
          password: "foo",
          password_confirmation: "bar"
        }}
      end.to_not change{ User.count }
      expect(response).to render_template('users/new')
    end
  end
end
