class OrderproductsController < ApplicationController
  before_action :find_orderproduct

  def update
    #binding.pry
    @orderproduct.status = params[:orderproduct][:status]
    if @orderproduct.save
      flash[:success] = "Status of ordered product has been changed."
      redirect_back(fallback_location: "get_orders")
    else
      flash[:failure] = "Status could not be changed."
      redirect_back(fallback_location: "get_orders")
    end
  end


private

  def find_orderproduct
    @orderproduct = Orderproduct.find_by(id: params[:id])
  end

end
