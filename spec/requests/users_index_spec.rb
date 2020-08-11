require 'rails_helper'

RSpec.describe "UserIndex", type: :request do

  fixtures :users
  before do
    @admin = users(:michael)
    @non_admin = users(:archer)
  end

  describe "when testing index page" do
    it "should include pagination" do
      log_in_as(@admin)
      get users_path
      expect(response).to render_template('users/index')
      User.paginate(page: 1).each do |user|
        assert_select 'a[href=?]', user_path(user), text: user.name
      end
    end

    it "should include pagination and delete links when logged as admin" do
      log_in_as(@admin)
      get users_path
      expect(response).to render_template('users/index')
      first_page_of_users = User.paginate(page: 1)
      first_page_of_users.each do |user| 
        assert_select 'a[href=?]', user_path(user), text: user.name
        unless user == @admin
          assert_select 'a[href=?]', user_path(user), text: 'delete'
        end
      end
      expect do 
        delete user_path(@non_admin)
      end.to change { User.count }
    end

    it "should not display any delete link when logged as non-admin" do
      log_in_as(@non_admin)
      get users_path
    assert_select 'a', text: 'delete', count: 0
    end
  end
end