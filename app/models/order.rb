class Order < ApplicationRecord
  has_many :orderproducts
  belongs_to :user, optional: true
end
