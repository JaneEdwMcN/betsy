class Orderproduct < ApplicationRecord
  belongs_to :order
  belongs_to :product


  def self.create_product_orders(order_id, session)
    session.each do |item|
      item.each do |key, value|
        binding.pry
        Orderproduct.create(product_id: key.to_i, quantity: value, order_id: order_id)
      end
    end
  end

end
