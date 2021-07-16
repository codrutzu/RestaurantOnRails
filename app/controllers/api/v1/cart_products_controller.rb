class Api::V1::CartProductsController < Api::V1::BaseController
  before_action :logged_in_user, only: %i[create index]
  skip_before_action :verify_authenticity_token

  def create
    cart = current_user.cart
    if (cart_product = CartProduct.find_by(product_id: params[:id], cart: cart))
      cart_product.update_columns(quantity: cart_product.quantity + 1)
    else
      cart.products << Product.find(params[:id])
    end

    render json: CartProduct.where(cart_id: current_user.cart.id), each_serializer: CartProductSerializer
  end

  def destroy
    cart_product = CartProduct.find(params[:id])
    if cart_product.quantity > 1
      cart_product.update_columns(quantity: cart_product.quantity - 1)
    else
      CartProduct.delete(cart_product)
    end

    render json: CartProduct.where(cart_id: current_user.cart.id), each_serializer: CartProductSerializer
  end

  def empty_cart
    CartProduct.where(cart_id: current_user.cart.id, product_id: params[:id]).destroy_all

    products = CartProduct.where(cart_id: current_user.cart.id)

    data = {
      products: ActiveModelSerializers::SerializableResource.new(products, each_serializer: CartProductSerializer),
      products_count: products.sum(:quantity)
    }

    render json: data
  end

  def index
    products = CartProduct.where(cart_id: current_user.cart.id)

    render json: products, each_serializer: CartProductSerializer
  end
end
