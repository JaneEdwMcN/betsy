class OrderproductsController < ApplicationController
  before_action :find_orderproduct

  def update
    @orderproduct.status = params[:status]
    if @orderproduct.save
      flash[:success] = "Status of ordered product has been changed."

    else
      flash[:failure] = "Status could not be changed."
    end
  end


private

  def find_orderproduct
    @orderproduct = Orderproduct.find_by(id: params[:id])
  end

end
