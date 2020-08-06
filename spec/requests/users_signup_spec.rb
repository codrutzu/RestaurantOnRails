require 'rails_helper'

RSpec.describe "Signup", type: :request do

  describe "signup" do
    it "should be valid" do
      get signup_path
      expect do
        post users_path, params: { user: 
          { name: "Example User", 
            email: "user@example.com", 
            password: "password", 
            password_confirmation: "password" 
          }}
      end.to change{ User.count }
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
