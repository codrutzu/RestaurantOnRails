require 'rails_helper'
require './spec/helpers/users_helper_spec'

RSpec.configure do |c|
  c.include UsersHelper
end

RSpec.describe "Login", type: :request do

  fixtures :all
  before do 
    @user = users(:michael)
  end
  
  describe "login" do
    it "should not login with invalid information" do
      get login_path
      expect(response).to render_template('sessions/new')
      post login_path, params: { session: {email: "invalid", password: "invalid"}}
      expect(response).to render_template('sessions/new')
      expect(flash.empty?).to be(false)
      get root_path
      expect(flash.empty?).to be(true)
    end

    it "should login with valid information" do
      get login_path
      post login_path, params: { session: {email: @user.email, password: 'password'} }
      expect(is_logged_in?).to be(true)
      expect(response).to redirect_to(@user)
      follow_redirect!
      expect(response).to render_template('users/show')
      delete logout_path
      expect(response).to redirect_to(root_path)
      expect(is_logged_in?).to be(false)
    end
  end
end
