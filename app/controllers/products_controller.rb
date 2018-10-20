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
    @product.update(product_params)
    category = Category.find_by(name: product_params[:category_id])
    @product.category_id = category.id
    if @product.save
      redirect_to product_path(@product)
    else
      render :edit, :status => :bad_request
    end
  end

  def add_to_cart
    id = @product.id.to_i
    quantity = params[:quantity].to_i
# session[:cart] = nil
    session[:cart].each.with_index do |hash, index|
      hash.each do |key, value|
        if key == id.to_s
          return session[:cart][index][key] = value + quantity
          redirect_to product_path(@product.id)
        end
      end
    end

    # # # # # @product.stock_count #something
    session[:cart] << { id => quantity}
    flash[:success] = "Added to cart"
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
