class Author < ApplicationRecord
  validates :name, presence: false, uniqueness: true
end