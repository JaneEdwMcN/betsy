require "test_helper"

describe Orderproduct do

  describe "relationships" do

    before do
      @orderproduct1 = orderproducts(:orderproduct1)
    end

    it "has a product" do
      @orderproduct1.must_respond_to :product
      @orderproduct1.product.must_be_kind_of Product
    end

    it "has an order" do
      @orderproduct1.must_respond_to :order
      @orderproduct1.order.must_be_kind_of Order
    end

  end

  describe "validations" do

    before do
      @goat = products(:goat)
      @order = orders(:complete_order)
    end

    it "allows the two valid categories" do
      valid_categories = ['pending', 'shipped']
      valid_categories.each do |category|
        orderproduct = Orderproduct.new(status: category, quantity: 1, order_id: @order.id, product_id: @goat.id)
        orderproduct.valid?.must_equal true
      end
    end

    it "rejects invalid categories" do
      invalid_categories = ['cat', 'dog', 'phd thesis', 1337, nil]
      invalid_categories.each do |category|
        orderproduct = Orderproduct.new(status: category, quantity: 1, order_id: @order.id, product_id: @goat.id)
        orderproduct.valid?.must_equal false
        orderproduct.errors.messages.must_include :status
      end
    end

    it "requires a status" do
      orderproduct = Orderproduct.new(quantity: 1, order_id: @order.id, product_id: @goat.id)
      orderproduct.valid?.must_equal false
      orderproduct.errors.messages.must_include :status
    end

    it "requires a quantity" do
      orderproduct = Orderproduct.new(status: "pending", order_id: @order.id, product_id: @goat.id)
      orderproduct.valid?.must_equal false
      orderproduct.errors.messages.must_include :quantity
    end

    it "a quantity needs to be an integer" do
      orderproduct = Orderproduct.new(status: "pending", quantity: "hello", order_id: @order.id, product_id: @goat.id)
      orderproduct.valid?.must_equal false
      orderproduct.errors.messages.must_include :quantity
    end

    it "requires an order_id" do
      orderproduct = Orderproduct.new(quantity: 1, status: "pending", product_id: @goat.id)
      orderproduct.valid?.must_equal false
      orderproduct.errors.messages.must_include :order_id
    end

    it "requires an product_id" do
      orderproduct = Orderproduct.new(quantity: 1, status: "pending", order_id: @order.id)
      orderproduct.valid?.must_equal false
      orderproduct.errors.messages.must_include :product_id
    end

  end

  describe "create_product_orders" do
    before do
      # @order = orders(:complete_order)
      # Need new order here because this one already has orderproducts

      @lamb = products(:lamb)
      @goat = products(:lamb)

      # @quantity_hash = { quantity: "3" }
      #Find out how/whether you can test sessions in Model tests
      # post add_to_cart_path(@lamb.id), params: @quantity_hash
      # post add_to_cart_path(@goat.id), params: @quantity_hash
    end

    it "creates orderproducts" do
      expect(@order.orderproducts.length.must_equal 0)

      Orderproduct.create_product_orders(@order.id, session[:cart])

      expect(@order.orderproducts.length.must_equal session[:cart].length)

      @order.orderproducts.each do |orderproduct|
        orderproduct.valid?.must_equal true
        orderproduct.must_be_kind_of Order
      end
    end

    # it "doesnt create an orderproduct if there isn't enough stock" do
    # end
  end

end
