require "test_helper"

describe OrdersController do

  describe "new" do
    it "succeeds" do
      get new_order_path

      must_respond_with :success
    end
  end

  describe "create" do
    let (:order_hash) do
      {
        order: {
          name: 'No OrderProducts McGee',
          email: 'testemail@gmail.com',
          mailing_address: '4150 Delridge Way SW',
          zip_code: 44903,
          cc_number: 8275928304958372,
          cc_expiration: '04/21',
          cc_cvv: 843,
          status: 'completed',
          total_cost: 8000
        }
      }
    end

    it "creates an order with paid status" do


      # Cannot figure out how to create a fake session hash!
      # session = {}
      # session[:cart] = [{"3" => 2}, {"1" => 1}]
      #
      # post orders_path, params: order_hash
      #
      # must_respond_with :redirect
      # expect(flash[:success]).must_equal 'Your purchase is complete!'
      # expect(order.status).must_equal 'paid'
    end
  end

  describe "new" do
    it "succeeds" do
      get new_order_path

      must_respond_with :success
    end
  end

  describe "update" do
    let (:order_params) do
      {
        order: {
          name: 'No OrderProducts McGee',
          email: 'testemail@gmail.com',
          mailing_address: '4150 Delridge Way SW',
          zip_code: 44903,
          cc_number: 8275928304958372,
          cc_expiration: '04/21',
          cc_cvv: 843,
          status: 'completed',
          total_cost: 8000
        }
      }
    end

    it "succeeds in updating order status" do
      complete_order = orders(:complete_order)

      expect {
        patch order_path(complete_order.id), params: order_params
      }.wont_change 'Order.count'

      must_respond_with :redirect
      must_redirect_to order_path(complete_order.id)

      expect(complete_order.status).must_equal order_params[:order][:status]
    end

    it "renders bad_request for updates if not given status param" do
      id = orders(:complete_order).id
      status = orders(:complete_order).status

      expect {
        patch order_path(id), params: nil
      }.wont_change 'Order.count'

      must_respond_with :bad_request
      expect(completed_order.status).must_equal status
    end

  end

end
