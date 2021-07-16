require 'rails_helper'

RSpec.describe CartProduct, type: :model do
  fixtures :users
  before do
    @user = users(:michael)
    @user.cart = Cart.new
  end
end
