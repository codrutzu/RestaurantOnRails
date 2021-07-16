class Admin::OrdersController < AdminController
  def index
    @orders = Order.where(handled: false).all.paginate(page: params[:page])
  end

  def update
    order = Order.find(params[:id])
    order.update_columns(handled: true)
    redirect_to admin_orders_path
  end
end
