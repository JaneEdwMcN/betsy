class OrdersController < ApplicationController
  def new
    @order = Order.new
  end

  def create
    @order = Order.new(order_params)
    @order.status = "pending"

    # session[:products].each do |key, value|
    #   # OrderProducts.new(key: value, order_id: @order.id)
    # end
    #
    # total_cost = 0
    # @order.orderproducts.each do |orderproduct|
    #   total_cost += (orderproduct.product.price * orderproduct.quantity)
    # end
    # @order.total_cost = total_cost

    if @order.save
      flash[:success] = 'Your purchase is complete!'
      redirect_to root_path
    else
      flash.now[:danger] = 'Unable to complete order'
      render :new, status: :bad_request
    end
  end

  # def edit; end
  #
  # def update
  #   if @order && @order.update(params[:status])
  #     redirect_to order_path(@order.id)
  #   elsif @order
  #     render :edit, status: :bad_request
  #   end
  # end

  private

  def find_order
    @order = Order.find_by(id: params[:id].to_i)

    if @order.nil?
      flash.now[:danger] = "Cannot find the order #{params[:id]}"
    end
  end

  def order_params
    return params.require(:order).permit(:name, :email, :mailing_address, :zip_code, :cc_number, :cc_expiration, :cc_cvv)
  end

end
