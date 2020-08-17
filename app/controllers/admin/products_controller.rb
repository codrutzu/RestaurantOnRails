class Admin::ProductsController < AdminController
  def new
    @product = Product.new
  end

  def show
    @product = Product.find(params[:id])
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to @product
    else
      flash[:danger] = 'You have to complete all fields'
      redirect_to new_admin_product_path
    end
  end

  private

  def product_params
    params.require(:product).permit(:title, :description, :price, :image)
  end
end
