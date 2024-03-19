class ArticleCategory < ApplicationRecord
  belongs_to :article
  belongs_to :category

  validates :article, uniqueness: { scope: :category }
end