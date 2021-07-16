require 'rails_helper'
require './spec/helpers/users_helper_spec'

RSpec.configure do |c|
  c.include UsersHelper
end

RSpec.describe 'UserIndex', type: :request do
  fixtures :users
  before do
    @admin = users(:michael)
    @admin.cart = Cart.new
    @non_admin = users(:archer)
    @non_admin.cart = Cart.new
  end

  describe 'when testing index page' do
    it 'should include pagination' do
      log_in_as(@admin)
      get admin_users_path
      expect(response).to render_template('users/index')
      User.paginate(page: 1).each do |user|
        assert_select 'a[href=?]', user_path(user), text: user.name
      end
    end

    it 'should include pagination and delete links when logged as admin' do
      log_in_as(@admin)
      get admin_users_path
      expect(response).to render_template('users/index')
      first_page_of_users = User.paginate(page: 1)
      first_page_of_users.each do |user|
        assert_select 'a[href=?]', user_path(user), text: user.name
      end
      expect do
        delete admin_user_path(@non_admin)
      end.to change { User.count }
    end

    it 'should not display any delete link when logged as non-admin' do
      log_in_as(@non_admin)
      get admin_users_path
    end
  end
end
