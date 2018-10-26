require "test_helper"

describe ProductsController do
  describe "index" do
    it "should get index" do
      get products_path
      must_respond_with :success
    end
  end

  describe "show" do
    it "will get show for valid ids" do
      id = products(:lamb).id
      get product_path(id)

      must_respond_with :success
    end

    it "will respond with not_found for invalid ids" do
      id = products(:lamb)
      products(:lamb).destroy

      get product_path(id)

      must_respond_with :not_found
    end
  end

  describe "new" do
    it "will load the new product" do
      get new_product_path

      must_respond_with :success
    end
  end

  describe "create" do
    it "can create a product" do
      product_hash = {
        product: {
          name: products(:lamb).id,
        }
      }

      expect {
        post product_path, params: product_hash
      }.must_change 'Product.count', 1

      must_respond_with  :redirect

      binding.pry
      expect(Product.last.name).must_equal product_hash[:product][:name]
    end
  end
end
