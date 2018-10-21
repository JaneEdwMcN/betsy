class User < ApplicationRecord
  has_many :products
  has_many :orders

  validates :name, uniqueness: true, presence: true
  validates :email, uniqueness: true, presence: true

  def total_revenue
    sum = 0
    self.products.each do |product|
      product.orderproducts.each do |orderproduct|
        sum += (orderproduct.product.cost * orderproduct.quantity)
      end
    end
    return sum
  end

  def self.build_from_github(auth_hash)
    User.new(
      uid: auth_hash[:uid],
      provider: 'github',
      name: auth_hash['info']['name'],
      email: auth_hash['info']['email']
    )
  end

  def self.create_from_github(auth_hash)
    user = build_from_github(auth_hash)
    user.save
    user
  end

end
