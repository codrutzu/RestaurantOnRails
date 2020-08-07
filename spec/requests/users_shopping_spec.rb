require 'rails_helper'

RSpec.describe "Adding to cart", type: :request do

  fixtures :all
  before do 
    @user = users(:michael)
    @user.cart = Cart.new
    @product = Product.new(title: 'Carbonara', description: 'pasta', price: 12)
    @product.image.attach(io: File.open(Rails.root.join('spec','images','soup.png')), filename: 'soup.png')
    @product.save!
  end
  
  describe "when a user is logged in" do
    it "should be able to add to cart" do
      get login_path
      expect(response).to render_template('sessions/new')
      post login_path, params: { session: 
        { 
          email: @user.email, 
          password: 'password'
        }}  
      expect(is_logged_in?).to be(true)
      expect(@user.cart.products.count).to eq(0)
      expect(flash.empty?).to be(true)
      product = Product.last
      expect(product.id).to eq(1)
      post '/add_product/1' 
      expect(@user.cart.products.count).to eq(1)
      expect(@user.cart.products.last).to eq(product)
    end
  end

  describe "when a user is not logged in" do
    it "shouldn't be able to add to cart" do
      get login_path
      post login_path, params: { session: 
        {
          email: "invalid",
          password:"invalid"
        }}
      expect(is_logged_in?).to be(false) 
      expect(@user.cart.products.count).to eq(0)
      post '/add_product/1'  
      expect(@user.cart.products.count).to eq(0)
      expect(flash.empty?).to be(false)
      get root_path
      expect(flash.empty?).to be(true)
    end
  end
end
