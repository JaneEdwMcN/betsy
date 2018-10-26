require "test_helper"

describe Product do
  describe "relationships do" do

    it "belongs to a category" do
      @product = products(:lamb)

      cat = @product.category.id

      cat.must_be_kind_of Integer
      @product.category.must_be_kind_of Category
    end

    it "belongs to a user" do
      @product = products(:lamb)

      tan = @product.user

      tan.must_be_kind_of User
    end
  end


  describe "validations do" do

    it "requires a name" do
      user = users(:tan)
      category = categories(:mystical)
      @product = Product.new(price: 20000, user_id: user.id, category_id: category.id)
      @product.valid?.must_equal false
      @product.errors.messages.must_include :name
    end

    it "requires a price" do
      user = users(:tan)
      category = categories(:mystical)
      @product = Product.new(name: "lamb", user_id: user.id, category_id: category.id)
      @product.valid?.must_equal false
      @product.errors.messages.must_include :price
    end
  end

  it "has a list of reviews" do
    @product.must_respond_to :reviews

    @product.reviews << reviews(:one)
    @product.reviews.each do |review|
      review.must_be_kind_of Review
    end
  end
  #review cant belong to two items
  it "adds product when price is a number" do
    user = users(:tan)
    category = categories(:mystical)
    @product = Product.new(name: "warthog", price: 3000, user_id: user.id, category_id: category.id)
    @product.valid?.must_equal true
  end

  it "does not add a product when price is not a number" do
    user = users(:tan)
    category = categories(:mystical)

    @product = Product.new(name: "lamb", price: "xyz", price: 3000, user_id: user.id, category_id: category.id)
    @product.valid?.must_equal false
    @product.errors.messages.must_include :price
  end

  it "requires a unique name do" do
    @product1 = Product.new(name: "lamb", price: 2000)
    @product1.save
    @product2 = Product.new(name: "lamb", price: 3000)
    @product2.save


    @product2.valid?.must_equal false
  end

  it "adds a product when both name and price are present" do
    user = users(:tan)
    category = categories(:mystical)
    @product = Product.new(name:"hippo", price: 4000, )
    @product.valid?.must_equal true
  end

  # it "adjusts stock count accoording to products sold" do
  #   Product.adjust_stock_count(1,2)
  #   expect(prod.stock_count).must_equal 8
  # end

end






# Product
# Name must be present
# Name must be unique
# Price must be present
# Price must be a number
# Price must be greater than 0
# Product must belong to a User
