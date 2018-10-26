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
      let (:product_hash) do
         {
      product: {
        name: "Tiger",
        stock_count: 10,
        description: "cute",
        price: 1100.0,
        user_id: users(:tan).id,
        photo_url: "https://i.imgur.com/NyKcY9y.jpg"
        }}
      end

      let (:bad_hash) do
        {
     product: {
       name: "Lion",
       stock_count: 8,
       description: "not cute",
       user_id: users(:tan).id,
       photo_url: "https://i.imgur.com/NyKcY9y.jpg"
       }}
     end

      it "can create a product" do

      expect {
        post products_path, params: product_hash
      }.must_change 'Product.count', 1

      must_respond_with  :redirect

      binding.pry
      expect(Product.last.name).must_equal product_hash[:product][:name]
      end

      it "cannot create a product with invalid data" do
        expect {
          post products_path, params: bad_hash
        }.must_change 'Product.count', 0

        must_respond_with  :bad_request

      end
    end

  describe "update" do
        let (:product_hash) do
          {
          product: {
            name: 'Lamb',
            stock_count: 10,
            description: "cute",
            price: 100.0,
            user_id: users(:tan).id,
            photo_url: "https://i.imgur.com/NyKcY9y.jpg"
          }}
        end

        let (:bad_hash) do
          {
       product: {
         name: "Lion",
         stock_count: 8,
         description: "not cute",
         user_id: users(:tan).id,
         photo_url: "https://i.imgur.com/NyKcY9y.jpg"
         }}
       end

  it "will update a product with a valid post request" do
    id = products(:lamb).id
    expect {
      patch product_path(id), params: product_hash
    }.wont_change 'Product.count'

    must_respond_with :redirect

    product = Product.find_by(id: id)
    must_respond_with :found
    must_respond_with  :redirect
    expect(product.name).must_equal product_hash[:product][:name]
    expect(product.stock_count).must_equal product_hash[:product][:stock_count]
    expect(product.description).must_equal product_hash[:product][:description]
    expect(product.price).must_equal product_hash[:product][:price]
    expect(product.user_id).must_equal product_hash[:product][:user_id]
    expect(product.photo_url).must_equal product_hash[:product][:photo_url]
  end

  it "will not update if the params are invalid" do
    id = products(:lamb).id
    original_product = products(:lamb)
    product_hash[:product][:name] = nil # invalid id
    expect {
      patch product_path(id), params: product_hash
    }.wont_change 'Product.count'

    must_respond_with :redirect

    product = Product.find_by(id: id)
    expect(product.name).must_equal original_product.name
    expect(product.stock_count).must_equal original_product.stock_count
  end

  # it "will respond with not_found for invalid ids" do
  #   id = -1
  #
  #   expect {
  #     patch book_path(id), params: book_hash
  #   }.wont_change 'Book.count'
  #
  #   must_respond_with :not_found
  # end
  end

end
