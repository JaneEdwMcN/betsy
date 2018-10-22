class ProductsController < ApplicationController
  before_action :find_product
  skip_before_action :find_product, only: [:index, :cart_view, :new, :create]

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
      flash[:success] = "New creature added!"
      redirect_to product_path(@product.id)
    else
      flash[:danger] = "Failed to save creature."
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
      flash[:success] = "Successfully updated creatures."
      redirect_to product_path(@product)
    else
      render :edit, :status => :bad_request
    end
  end

  def add_to_cart
    id = @product.id.to_i
    quantity = params[:quantity].to_i
    # session[:cart] = nil
    if [*1..@product.stock_count].include? (quantity)
      item = false
      session[:cart].each.with_index do |hash, index|
        hash.each do |key, value|
          if key == id.to_s
            item = true
            new_quantity = value + quantity
            if new_quantity <= @product.stock_count
              session[:cart][index][key] = value + quantity
              flash[:success] = "Added to cart"
            else
              flash[:warning] = "Failure to add to cart. Not enough stock."
            end
          end
        end
      end
      if item == false
        session[:cart] << { id => quantity}
        flash[:success] = "Added to cart"
      end
    else
      flash[:warning] = "Failure to add to cart. Invalid quantity."
    end
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
    if [*1..@product.stock_count].include? (quantity)
      session[:cart].each.with_index do |hash, index|
        hash.each do |key, value|
          if key == id.to_s
            session[:cart][index][key] = quantity
            flash[:success] = "Successfully updated cart."
          end
        end
      end
    else
      flash[:warning] = "Failure to add to cart. Invalid quantity."
    end
    redirect_to cart_path
  end

  def remove_from_cart
    id = @product.id.to_i
    session[:cart].each.with_index do |hash, index|
      hash.each do |key, value|
        if key == id.to_s
          session[:cart].delete_at(index)
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
    if !@product
      @product = Product.find_by(id: params[:product_id])
    end
    if @product.nil?
      render :notfound, status: :not_found
    end
  end

end
