class AuthorsController < ApplicationController
  def show
    @author = Author.find(params[:id])
    @articles = @author.articles
  end
end
