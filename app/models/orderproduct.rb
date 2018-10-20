class Orderproduct < ApplicationRecord
  belongs_to :order
  belongs_to :product


  def create_product_orders(order_id, )
    session[:cart].each do |key, value|
      OrderProducts.new(product_id: key, quantity: value, order_id: order_id)
    end
  end

end
