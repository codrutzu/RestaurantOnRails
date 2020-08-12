require 'rails_helper'

RSpec.describe "PasswordResets", type: :request do
  
  fixtures :users
  before do 
    ActionMailer::Base.deliveries.clear
    @user = users(:michael)
  end

  describe "when testing password reset" do 
    it "get path" do 
      get new_password_reset_path
      expect(response).to render_template('password_resets/new')
      assert_select 'input[name=?]', 'password_reset[email]'
    end
    
    it "should not reset it" do
      # Invalid email 
      post password_resets_path, params: { password_reset: 
        {
          email: ""
        }}
      expect(flash.empty?).to be(false)
      expect(response).to render_template('password_resets/new')
      post password_resets_path, params: { password_reset: 
      {
        email: @user.email
      }}
      user = assigns(:user)
      patch password_reset_path(user.reset_token), params: 
        {
          email: user.email,
          user: 
            {
              password: "",
              password_confirmation: ""
            }
        }
      expect(response).to render_template('edit')
    end

    it "should reset it" do
      # Valid email
      post password_resets_path, params: { password_reset: 
      { 
        email: @user.email
      }}
      expect(@user.reload.reset_digest).to eq(@user.reset_digest)
      expect(ActionMailer::Base.deliveries.size).to eq(1)
      expect(flash.empty?).to be(false)
      expect(response).to redirect_to(root_url)
      user = assigns(:user)
      patch password_reset_path(user.reset_token), params:  
        {
          email: user.email,
          user: 
            {
              password: "foobaz",
              password_confirmation: "foobaz"
            }
        }
      expect(is_logged_in?).to be(true)
      expect(flash.empty?).to be(false)
      expect(response).to redirect_to(@user)
    end
  end
end
