class Category < ApplicationRecord
  has_many :products
  validates :name, presence: true, uniqueness: true

  def self.category_list
    category_list = []
    Category.all.each do |cat|
      category_list << cat.name
    end
    category_list
  end

end
