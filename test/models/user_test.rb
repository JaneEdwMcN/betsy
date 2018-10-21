require "test_helper"

describe User do
  describe "relations" do
    let(:kit) { users(:kit) }

    it "has a list of products" do
      kit.must_respond_to :products

      kit.products.each do |product|
        product.must_be_kind_of Product
      end
    end

    it "has a list of orders" do
      kit.must_respond_to :orders

      kit.products.each do |order|
        product.must_be_kind_of Order
      end
    end
  end

  describe "validations" do
    it  "requires a name and email" do
      user = User.new
      user.valid?.must_equal false
      user.errors.messages.must_include :name, :email
    end

    it  "requires a unique user name and email" do
      user1 = User.new(name: 'mat', email: 'mat@gmail.com',
         uid: 1234, provider: 'github')
      user1.save!

      user2 = User.new(name: 'mat', email: 'mat@gmail.com',
         uid: 1234, provider: 'github')
      result = user2.save

      result.must_equal false
      user2.errors.messages.must_include :name, :email
    end
  end

  describe 'custom methods' do
    describe 'total_revenue' do
    end
    describe 'build_from_github(auth_hash)' do
    end
    describe 'create_from_github(auth_hash)' do
    end
  end

end
