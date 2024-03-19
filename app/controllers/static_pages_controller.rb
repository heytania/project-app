class StaticPagesController < ApplicationController
  def home
    @categories = Category.all
    @articles = Article.includes(:author, :publisher, :countries)

    if params[:category_id].present?
      @articles = @articles.joins(:article_categories).where(article_categories: { category_id: params[:category_id] })
    end

    if params[:search].present?
      @articles = @articles.where("title LIKE ?", "%#{params[:search]}%")
    end

    @articles = @articles.page(params[:page]).per(10) # Paginate with 10 articles per page

    @countries = Country.joins(:article_countries).distinct
  end

  def about
  end
end
