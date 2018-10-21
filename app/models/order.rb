class Order < ApplicationRecord
  has_many :orderproducts
  validates :orderproducts, :length => { :minimum => 1 }
  validates :name, :email, :mailing_address, :zip_code, :cc_number,
  :cc_expiration, :cc_cvv, :status, :total_cost, presence: true, on: :update

  def order_total
    total_cost = 0
    self.orderproducts.each do |orderproduct|
      total_cost += (orderproduct.product.price * orderproduct.quantity)
    end
    total_cost
  end

  def reduce_stock
    self.orderproducts.each do |item|
      Product.adjust_stock_count(item.product_id, item.quantity)
    end
  end

end
