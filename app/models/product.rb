class Product < ApplicationRecord
  belongs_to :user
  has_many :reviews
  has_many :orderproducts
  belongs_to :category

  def self.adjust_stock_count(product_id, count_sold)
    product = Product.find(product_id)
    reduced_stock = product.stock_count - count_sold
    product.update(stock_count: reduced_stock)
    product.save
  end

end
