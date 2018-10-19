class Order < ApplicationRecord
  has_many :orderproducts
  belongs_to :user, optional: true

  validates :name, :email, :mailing_address, :zip_code, :cc_number,
  :cc_expiration, :cc_cvv, :status, :tota_cost, presence: true, on: :update

  def order_total
    total_cost = 0
    @order.orderproducts.each do |orderproduct|
      total_cost += (orderproduct.product.price * orderproduct.quantity)
    end
    total_cost
  end

end
