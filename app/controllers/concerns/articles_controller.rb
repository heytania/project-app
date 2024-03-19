
class ArticlesController < ApplicationController
    def index
      @articles = Article.all.includes(:author, :publisher, :categories, :countries)
    end
  end
  