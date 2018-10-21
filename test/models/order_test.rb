require "test_helper"

describe Order do
  describe "validations" do
    let(:order) { Order.create(status: "pending") }

    it "must be invalid without customer info provided" do
      order.valid?.must_equal false
    end

    it "will not update order without all customer info" do
      order2 = orders(:complete_order)

      order2.valid?.must_equal true
      order2.update(name:nil)
      order2.valid?.must_equal false
      expect(order2.save).must_equal false
      order2.update(name:"Monique Marie")
      order2.valid?.must_equal true

      order2.update(email:nil)
      order2.valid?.must_equal false
      expect(order2.save).must_equal false
      order2.update(email:"testemail@gmail.com")
      order2.valid?.must_equal true

      order2.update(mailing_address:nil)
      order2.valid?.must_equal false
      expect(order2.save).must_equal false
      order2.update(mailing_address:"4150 Delridge Way SW")
      order2.valid?.must_equal true

      order2.update(zip_code:nil)
      order2.valid?.must_equal false
      expect(order2.save).must_equal false
      order2.update(zip_code:44903)
      order2.valid?.must_equal true

      order2.update(cc_number:nil)
      order2.valid?.must_equal false
      expect(order2.save).must_equal false
      order2.update(cc_number:8275928304958372)
      order2.valid?.must_equal true

      order2.update(cc_expiration:nil)
      order2.valid?.must_equal false
      expect(order2.save).must_equal false
      order2.update(cc_expiration:"04/21")
      order2.valid?.must_equal true

      order2.update(cc_cvv:nil)
      order2.valid?.must_equal false
      expect(order2.save).must_equal false
      order2.update(cc_cvv:843)
      order2.valid?.must_equal true
    end
  end

  describe "relations" do
    let(:order) {
      Order.new(name:"No OrderProducts McGee", email:"testemail@gmail.com",
        mailing_address:"4150 Delridge Way SW", zip_code:44903,
        cc_number: 8275928304958372, cc_expiration: "04/21", cc_cvv: 843,
        status: "paid", total_cost: 8000)
    }

    it "must have one or many orderproducts" do
      #no orderproducts attached
      expect(order.save).must_equal false

      #adding orderproduct to order
      orderproduct1 = orderproducts(:orderproduct1)
      order.orderproducts << orderproduct1
      expect(order.save).must_equal true
      expect(order.orderproducts.length).must_be :>, 0
    end
  end

  describe "order model methods" do
    describe "Order#order_total" do
      it "will tally the cost of products for a given order" do
        order = orders(:complete_order)
        
        expect(order.order_total).must_equal 300

      end
    end

    describe "Order#reduce_stock" do
      it "will reduce product stock related to a given order" do

      end
    end
  end
end
