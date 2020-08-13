require 'rails_helper'
require './spec/helpers/users_helper_spec'

RSpec.configure do |c|
  c.include UsersHelper
end

RSpec.describe "Login", type: :request do
  fixtures :users
  before do
    @user = users(:michael)
    @user.cart = Cart.new
  end

  describe 'login' do
    it 'should not login with invalid information' do
      get login_path
      expect(response).to render_template('sessions/new')
      expect(flash.empty?).to be(true)
      post login_path, params: { session:
        {
          email: 'invalid@invalid',
          password: 'invalid'
        }}
      expect(response).to redirect_to(login_path)
      expect(flash.empty?).to be(false)
      get login_path
      # IDK why this isn't working
      expect(flash.empty?).to be(true)
    end

    it 'should login with valid information' do
      get login_path
      post login_path, params: { session:
        {
          email: @user.email,
          password: 'password'
        }}
      expect(is_logged_in?).to be(true)
      expect(response).to redirect_to(@user)
      follow_redirect!
      expect(response).to render_template('users/show')
      delete logout_path
      expect(response).to redirect_to(root_path)
      expect(is_logged_in?).to be(false)
      # Simulate a user clicking logout in a second window.
      delete logout_path
    end
  end

  describe 'testing remembering' do
    it 'should remember the user' do
      log_in_as(@user, remember_me: '1')
      expect(cookies[:remember_token]).not_to be_empty
    end

    it 'should not remember the user' do
      log_in_as(@user, remember_me: '1')
      log_in_as(@user, remember_me: '0')
      expect(cookies[:remember_token]).to be_empty
    end
  end
end
