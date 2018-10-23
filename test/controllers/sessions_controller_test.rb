require "test_helper"
require 'pry'
describe SessionsController do
  describe 'create' do
    let(:kit) { users(:kit) }

    it "logs in an exiting user and redirects to the root route" do
      expect {perform_login(kit)}.wont_change('User.count')

      must_redirect_to root_path
      expect(session[:user_id]).must_equal kit.id
    end

    # it "creates an account for a new user and redirects to the root route" do
    #    user = users(:kit)
    #    user.destroy
    #
    #    expect{perform_login(user)}.must_change('User.count', +1)
    #
    #    must_redirect_to root_path
    #    expect(session[:user_id]).wont_be_nil id
    #  end

    it "redirects to the login route if given invalid user data" do

    end
  end

  describe 'add_to_cart' do
    before do
      @lamb = products(:lamb)
      @quantity_hash = { quantity: "3" }
    end

    it "adds a new product to a cart" do
      #add to cart
      post add_to_cart_path(@lamb.id), params: @quantity_hash

      #check quantity against quantity_hash
      expect(session[:cart]).must_include @lamb.id => @quantity_hash[:quantity].to_i
      must_respond_with :redirect
    end

    it "updates the quantity of the cart" do
      #add to cart
      post add_to_cart_path(@lamb.id), params: @quantity_hash

      #check quantity against quantity_hash
      expect(session[:cart].first.values[0]).must_equal @quantity_hash[:quantity].to_i

      #add to cart again
      post add_to_cart_path(@lamb.id), params: @quantity_hash

      #check quantity against quantity_hash times two
      expect(session[:cart].first.values[0]).must_equal @quantity_hash[:quantity].to_i * 2
      must_respond_with :redirect
    end

    it "won't add to cart if there isn't enough stock or invalid stock" do
      large_quantity_hash = { quantity: "20" }
      post add_to_cart_path(@lamb.id), params: large_quantity_hash
      expect(session[:cart]).must_equal []

      invalid_quantity_hash = {quantity: "hello"}
      post add_to_cart_path(@lamb.id), params: invalid_quantity_hash
      expect(session[:cart]).must_equal []
    end
  end

  describe 'remove_from_cart' do
    before do
      @lamb = products(:lamb)
      @goat = products(:goat)
      @quantity_hash = { quantity: "3" }
      post add_to_cart_path(@lamb.id), params: @quantity_hash
    end

    it "removes item from cart" do
      expect(session[:cart].length).must_equal 1

      get remove_from_cart_path(@lamb.id)
      expect(session[:cart].length).must_equal 0
    end

    it "removes specific item from cart" do
      post add_to_cart_path(@goat.id), params: @quantity_hash

      expect(session[:cart].length).must_equal 2

      get remove_from_cart_path(@lamb.id)
      expect(session[:cart].length).must_equal 1
      expect(session[:cart]).wont_include @lamb.id => @quantity_hash[:quantity].to_i
      expect(session[:cart]).must_include @goat.id.to_s => @quantity_hash[:quantity].to_i
    end

  end

end
