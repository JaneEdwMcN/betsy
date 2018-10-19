class ProductsController < ApplicationController
  before_action :find_product

  def index
    @products = Product.order(:name)
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    category = Category.find_by(name: product_params[:category_id])
    @product.category_id = category.id
    if @product.save
      redirect_to product_path(@product.id)
    else
      flash[:failure] = "failed to save"
      render :new, :status => :bad_request
    end
  end

  def show
  end

  def edit;end

  def update
    if @product.save
      redirect_to product_path(@product)
    else
      render :edit, :status => :bad_request
    end
  end

  def add_to_cart
    id = @product.id
    quantity = 1
    session[:cart] << { id => quantity}
    redirect_to product_path(@product.id)
  end

  private
  def product_params
    return params.require(:product).permit(:name, :price, :stock_count, :user_id, :photo_url, :description, :category_id)
  end

  def find_product
    @product = Product.find_by(id: params[:id])
    if !@product
      @product = Product.find_by(id: params[:product_id])
    end

  end

end
