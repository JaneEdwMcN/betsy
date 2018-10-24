class OrdersController < ApplicationController
  before_action :find_order
  skip_before_action :find_order, only: [:fulfillment, :paid, :completed, :new, :completed, :cancelled]

  def new
    @order = Order.new
  end

  def show; end

  def fulfillment
     @orderproducts = Order.find_orderproducts(@current_user, nil)
     @total_revenue = Order.products_sold_total(@current_user, @orderproducts)
     @count = Order.count_orders(@current_user, nil)
  end

  def paid
    @orderproducts = Order.find_orderproducts(@current_user, "paid")
    @total_revenue = Order.products_sold_total(@current_user, @orderproducts)
    @count = Order.count_orders(@current_user, "paid")
  end

  def completed
    @orderproducts = Order.find_orderproducts(@current_user, "completed")
    @total_revenue = Order.products_sold_total(@current_user, @orderproducts)
    @count = Order.count_orders(@current_user, "completed")
  end

  def cancelled
    @orderproducts = Order.find_orderproducts(@current_user, "cancelled")
    @total_revenue = Order.products_sold_total(@current_user, @orderproducts)
    @count = Order.count_orders(@current_user, "cancelled")
  end

  def create
    @order = Order.new
    @order.status = "pending"
    @order.save
    Orderproduct.create_product_orders(@order.id, session[:cart])
    @order.total_cost = @order.order_total
    @order.update(order_params)
    if @order.save
      @order.reduce_stock
      @order.status = "paid"
      @order.save
      flash[:success] = 'Your purchase is complete!'
      session[:cart] = nil
      redirect_to root_path
    else
      flash.now[:danger] = 'Unable to complete order'
      render :new, status: :bad_request
    end
  end

  # def edit; end
  #
  def update
    if @order && @order.update(order_params)
      @order.save
      flash[:success] = 'Status has been changed.'
      redirect_to order_path(@order.id)
    elsif @order
      render :edit, status: :bad_request
    end
  end

  def search
    @order = Order.find_by(id: params[:order_id])

    if @order
      redirect_to order_path(@order)
    else
      flash[:warning] = "Order #{params[:order_id]} does not exist"
      redirect_back fallback_location: root_path
    end
  end


  private

  def find_order
    @order = Order.find_by(id: params[:id].to_i)

    if @order.nil?
      flash.now[:danger] = "Cannot find the order #{params[:id]}"
    end
  end

  def order_params
    return params.require(:order).permit(:name, :email, :mailing_address, :zip_code, :cc_number, :cc_expiration, :cc_cvv, :total_cost, :status)
  end

end
