require "test_helper"

describe Product do

    it "has a list of categories" do
      @product.categories << categories(:sleepy)
      @product.must_respond_to :categories

      @product.categories.each do |category|
        category.must_be_kind_of Category
      end
    end

    it "has a list of reviews" do
      @product.must_respond_to :reviews

      @product.reviews << reviews(:one)
      @product.reviews.each do |review|
        review.must_be_kind_of Review
    end

      #review cant belong to two items
end
