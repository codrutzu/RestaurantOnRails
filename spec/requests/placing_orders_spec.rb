require 'rails_helper'
require './spec/helpers/users_helper_spec'
require './spec/helpers/product_helper_spec'

RSpec.configure do |c|
  c.include UsersHelper
  c.include ProductsHelper
end

RSpec.describe "OrderDetails", type: :request do
  fixtures :users
  before do
    @user = users(:archer)
    @user.cart = Cart.new
    @product = Product.new(title: 'Carbonara', description: 'pasta', price: 12)
    @product.image.attach(io: File.open(Rails.root.join('spec', 'images', 'soup.png')), filename: 'soup.png')
    @product.save!
  end

  describe 'when a user is logged in' do
    it 'should be able to place an order if he has items in cart' do
      get login_path
      post login_path, params: { session:
        {
          email: @user.email,
          password: 'password'
        }}
      expect(is_logged_in?).to be(true)
      post add_product_path, params:
        {
          id: @product.id,
          cart: @user.cart
        }
      post orders_path, params: { order:
        {
          address: 'Test',
          city: 'test',
          phone: '999999'
        }}
      expect(OrderProduct.all.count).to eq(1)
    end
    it 'should not create an order with no products' do
      get login_path
      post login_path, params: { session:
        {
          email: @user.email,
          password: 'password'
        }}
      post orders_path, params: { order:
        {
          address: 'Test',
          city: 'test',
          phone: '999999'
        }}
      expect(response).to redirect_to(new_order_path)
    end
  end

  describe 'when a user is not logged in' do
    it 'should redirect him to log in page' do
      post orders_path, params: { order:
        {
          address: 'Test',
          city: 'test',
          phone: '999999'
        }}
      expect(response).to redirect_to(login_path)
    end
  end
end
