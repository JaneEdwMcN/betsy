class User < ApplicationRecord
  has_many :products
  has_many :orders
  
  def total_revenue
    sum = 0
    self.products.each do |product|
      product.orderproducts.each do |orderproduct|
        sum += (orderproduct.product.cost * orderproduct.quantity)
      end
    end
    return sum
  end

end
