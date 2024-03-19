class ArticleCountry < ApplicationRecord
  belongs_to :article
  belongs_to :country

  validates :article, uniqueness: { scope: :country }
end