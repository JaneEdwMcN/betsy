require "test_helper"

describe Product do
  describe "relationships do" do

    it "has and belongs to many categories" do
      product = products(:lamb)
      category1 = categories(:mystical)
      category2 = categories(:dangerous)
      product.categories << category1
      product.categories << category2

      expect(product.categories.first).must_be_kind_of Category
      expect(product.categories.length).must_equal 2
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

  it "adjusts stock count according to products sold" do

    product = products(:lamb)

    Product.adjust_stock_count(product.id, 2)
    product.reload
    expect(product.stock_count).must_equal 8
  end

  it "gives average rating for review" do

     product = products(:lamb)
     rating = product.average_rating

    expect(rating).must_equal 3
  end

  it "checks if product is in cart already" do
    product = products(:lamb)
    session = [{product.id=>3}]
    cart = product.in_cart?(session)
    expect(cart).must_be true
  end

  # def in_cart?(session)
  #   session.each do |item|
  #     item.each do |key, value|
  #       return true if key.to_i == self.id
  #     end
  #   end
  #   return false
  # end
  #
  # def cart_adjust_quantity(session)
  #   session.each do |item|
  #     item.each do |id, quantity|
  #       return self.stock_count - quantity if id.to_i == self.id
  #     end
  #   end
  # end


end
