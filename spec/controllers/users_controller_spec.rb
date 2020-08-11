require 'rails_helper' 

RSpec.describe "UserController", type: :request do

  fixtures :users
  before do 
    @user = users(:michael)
    @other_user = users(:archer)
  end

  describe "when testing user controller" do
    it "should redirect index when not logged in" do
      get users_path
      expect(response).to redirect_to(login_url)
    end

    it "should redirect destroy when not logged in" do
      expect do
        delete user_path(@user)
      end.to_not change { User.count }
      expect(response).to redirect_to(login_url)
    end

    it "should redirect destroy when logged in as non-admin" do
      log_in_as(@other_user)
      expect do 
        delete user_path(@user)
      end.to_not change { User.count }
      expect(response).to redirect_to(root_url)
    end
  end
end