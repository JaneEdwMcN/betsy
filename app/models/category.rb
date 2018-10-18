class Category < ApplicationRecord
  has_many :products, index: true
end
