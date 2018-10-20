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
          new_quantity = value + quantity
          if new_quantity <= @product.stock_count
            session[:cart][index][key] = value + quantity
            redirect_to product_path(@product.id)
            return
          else
            flash[:failure] = "Failure to add to cart. Not enough stock."
            redirect_to product_path(@product.id)
            return
          end
        end
      end
    end
    session[:cart] << { id => quantity}
    flash[:success] = "Added to cart"
    redirect_to product_path(@product.id)
  end

  def cart_view
    @cart_items = []
    session[:cart].each.with_index do |hash|
      hash.each do |key, value|
        cart_product = Product.find_by(id: key.to_i)
        @cart_items << [cart_product, value]
      end
    end
    render :cart
  end

  def update_quantity
    id = @product.id.to_i
    quantity = params[:quantity].to_i

    session[:cart].each.with_index do |hash, index|
      hash.each do |key, value|
        if key == id.to_s
          session[:cart][index][key] = quantity
          flash[:success] = "Successfully updated cart."
          redirect_to cart_path
        end
      end
    end
  end

  def remove_from_cart
    id = @product.id.to_i
    session[:cart].each.with_index do |hash, index|
      hash.each do |key, value|
        if key == id.to_s
          session[:cart][index][key] = 0
          flash[:success] = "Successfully removed from cart."
          redirect_to cart_path
        end
      end
    end
  end

  private
  def product_params
    return params.require(:product).permit(:name, :price, :stock_count, :user_id, :photo_url, :description, :category_id)
  end

  def find_product
    @product = Product.find_by(id: params[:id])
    if @product.nil?
      render :notfound, status: :not_found
    end
    # if !@product
    #   @product = Product.find_by(id: params[:product_id])
    # end

  end

end
