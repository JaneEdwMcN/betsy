require "test_helper"

describe CategoriesController do
  let (:categories_hash) do
    {
      category: {
        name: 'Mammal'
      }
    }
  end
describe "index" do
  it "should get index" do
    get categories_path
    must_respond_with :success
  end
end

describe "show" do
  it "will get show for valid ids" do
    id = categories(:mystical).id

    get category_path(id)

    must_respond_with :success
  end

  it "will respond with not_found for invalid ids" do
    id = categories(:mystical)
    categories(:mystical).destroy

    get category_path(id)

    must_respond_with :not_found
  end
end

describe "new" do
  it "will load the new book page" do
    get new_category_path

    must_respond_with :success
  end
end

describe "create" do
  it "can create a category" do
    category_hash = {
      category: {
        name: categories(:mystical).id,
      }
    }

    expect {
      post category_path, params: category_hash
    }.must_change 'Category.count', 1

    must_respond_with  :redirect

    expect(Category.last.name).must_equal category_hash[:category][:name]
  end
end
end
