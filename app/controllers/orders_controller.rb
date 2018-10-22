class OrdersController < ApplicationController
  before_action :find_order
  skip_before_action :find_order, only: [:fulfillment, :new]


  def new
    @order = Order.new
  end

  def fulfillment
     @orders = Order.find_orders(@current_user)
     @total_revenue = Order.products_sold_total(@current_user)
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
    if @order && @order.update(params[:status])
      redirect_to order_path(@order.id)
    elsif @order
      render :edit, status: :bad_request
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
    return params.require(:order).permit(:name, :email, :mailing_address, :zip_code, :cc_number, :cc_expiration, :cc_cvv, :total_cost)
  end

end
