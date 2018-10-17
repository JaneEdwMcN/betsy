class AddColumnsProduct < ActiveRecord::Migration[5.2]
  def change
    add_column :product, :stock_count, :integer
    add_column :product, :user_id
    add_column :product, :price, :integer
    add_column :product, :category, :string
    add_column :product, :photo_url, :string
    add_column :product, :description, :string
    add_column :product, :name, :string

  end
end
