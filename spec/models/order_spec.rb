require 'rails_helper'

RSpec.describe Order, type: :model do
  fixtures :users
  before do
    @order = Order.new(address: 'Test', city: 'Test', phone: '0000000')
    @user = users(:archer)
    @order.user = @user
  end

  describe 'validations' do
    context 'when creating a valid new use' do
      it 'should be valid' do
        expect(@order.valid?).to be(true)
      end
      it 'should have an address' do
        @order.address = ''
        expect(@order.valid?).to be(false)
      end
      it 'should have a city' do
        @order.city = ' '
        expect(@order.valid?).to be(false)
      end
      it 'should have a phone number' do
        @order.phone = ' '
        expect(@order.valid?).to be(false)
      end
    end
  end
end
