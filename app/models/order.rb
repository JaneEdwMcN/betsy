class Order < ApplicationRecord
  has_many :orderproducts
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

  def self.find_orders(user)
    orders = []
    Order.all.each do |order|
      order.orderproducts.each do |item|
        product = item.product
        if user.id == product.user_id
          orders << order
        end
      end
    end
    orders
  end

  def self.products_sold_total(user, orders)
    total_revenue = 0
    orders.each do |order|
      order.orderproducts.each do |item|
        product = item.product
        if user.id == product.user_id
          per_unit_cost = item.product.price
          total_revenue += item.quantity * per_unit_cost
        end
      end
    end
    total_revenue
  end



end
