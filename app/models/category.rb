# app/models/category.rb
class Category < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  has_many :items
end

# app/models/item.rb
class Item < ApplicationRecord
  belongs_to :category
end
