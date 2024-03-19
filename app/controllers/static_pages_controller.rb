class StaticPagesController < ApplicationController

  def home
    @categories = Category.all
    @articles = Article.all.includes(:author, :publisher, :countries)

    if params[:category_id].present?
      @articles = @articles.joins(:article_categories).where(article_categories: { category_id: params[:category_id] })
    end

    if params[:search].present?
      @articles = @articles.where("title ILIKE ?", "%#{params[:search]}%")
    end
    @countries = Country.joins(:article_countries).distinct
  end

  def about
  end
end
