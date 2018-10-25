require "test_helper"
require 'pry'

describe Review do
  describe "relationships" do
    before do
      @review = reviews(:one)
      @lamb = products(:lamb)
    end

    it "belongs to a product" do
      @review.must_respond_to :product
      @review.product.must_be_kind_of Product
    end

    it "has a product id" do
      @review.product_id.must_equal @lamb.id
    end
  end
  name rating review product_id

  describe "validations" do
    before do
      @review = reviews(:one)
      @goat = products(:goat)
    end

    it "has a rating" do
      review = Review.new(name: "Wendy", rating: 3, review: "Wonderful goat.", product_id: )
      user.valid?.must_equal false
    end

    it "has a rating between 1 and 5" do
    end

    it "it's rating is a number" do
    end

    it "has a name" do
    end

    it "has a review" do
    end
  end

end
