require 'rails_helper'

RSpec.describe "UsersEditTests", type: :request do

  fixtures :users
  before do
    @user = users(:michael)
    @user.cart = Cart.new
    @other_user = users(:archer)
    @other_user.cart = Cart.new
  end

  describe 'when editing a user' do
    it "should be unsuccessful" do
      log_in_as(@user)
      get edit_user_path(@user)
      expect(response).to render_template('users/edit')
      patch user_path(@user), params: { user:
        {
          name: '',
          email: 'foo@invalid',
          password: 'foo',
          password_confirmation: 'bar'
        }}
        expect(response).to render_template('users/edit')
    end

    it "should be successful" do
      log_in_as(@user)
      get edit_user_path(@user)
      expect(response).to render_template('users/edit')
      name = "Foo Bar"
      email = "foo@bar.com"
      patch user_path(@user), params: { user:
        {
          name: name,
          email: email,
          password: '',
          password_confirmation: ''
        }}
      expect(flash.empty?).to be(false)
      expect(response).to redirect_to(@user)
      @user.reload
      expect(name).to eq(@user.name)
      expect(email).to eq(@user.email)
    end

    it "should redirect edit when not logged in" do
      get edit_user_path(@user)
      expect(flash.empty?).to be(false)
      expect(response).to redirect_to(login_url)
    end

    it "should redirect update when not logged in" do
      patch user_path(@user), params: { user:
        {
          name: @user.name,
          email: @user.email
        }}
        expect(flash.empty?).to be(false)
        expect(response).to redirect_to(login_url)
    end

    it "should redirect edit when logged in as wrong user" do
      log_in_as(@other_user)
      get edit_user_path(@user)
      expect(flash.empty?).to be(true)
      expect(response).to redirect_to(root_url)
    end

    it "should redirect update when logged in as wrong user" do
      log_in_as(@other_user)
      patch user_path(@user), params: { user:
        {
          name: @user.name,
          email: @user.email
        }}
      expect(flash.empty?).to be(true)
      expect(response).to redirect_to(root_url)
    end

    it "should forward to edit page after log in" do
      get edit_user_path(@user)
      log_in_as(@user)
      expect(response).to redirect_to(edit_user_path(@user))
      name = "Foo Bar"
      email = "foo@bar.com"
      patch user_path(@user), params: { user:
        {
          name: name,
          email: email,
          password: "",
          password_confirmation: ""
        }}
        expect(flash.empty?).to be(false)
        expect(response).to redirect_to(@user)
        @user.reload
        expect(@user.name).to eq(name)
        expect(@user.email).to eq(email)
    end
  end
end
