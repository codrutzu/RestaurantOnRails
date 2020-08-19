class Admin::OrdersController < AdminController
  def index
    @orders = Order.where(handled: false).all.paginate(page: params[:page])
  end

  def destroy
    order = Order.find(params[:id])
    order.update_columns(handled: true)
    flash[:succes] = 'Order handled'
    redirect_to admin_orders_path
  end
end
