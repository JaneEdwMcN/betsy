class Product < ApplicationRecord
  belongs_to :user
  has_many :reviews
  has_many :orderproducts
  belongs_to :category
end
