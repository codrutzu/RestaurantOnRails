class Api::V1::CartProductsController < Api::V1::BaseController
  # before_action :authorize_user!, only: :create
  skip_before_action :verify_authenticity_token

  def create
    cart = current_user.cart
    if (cart_product = CartProduct.find_by(product_id: params[:id], cart: cart))
      cart_product.update_columns(quantity: cart_product.quantity + 1)
    else
      cart.products << Product.find(params[:id])
    end

    head :ok
  end
end
