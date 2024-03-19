class Article < ApplicationRecord
  belongs_to :author
  belongs_to :publisher

  has_many :article_countries
  has_many :countries, through: :article_countries

  has_many :article_categories
  has_many :categories, through: :article_categories

  validates :title, presence: true
  validates :link, presence: true, uniqueness: true
  validates :published_date, presence: true
  validates :description, presence: false
  validates :language, presence: false
end