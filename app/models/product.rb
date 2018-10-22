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

  def average_rating
    sum = self.reviews.reduce(0) do |sum, review|
      sum += review.rating
    end
    return sum / self.reviews.length if self.reviews.length > 0
    return sum
  end

end
