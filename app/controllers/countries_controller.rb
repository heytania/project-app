class CountriesController < ApplicationController
  def show
    @country = Country.find(params[:id])
    @articles = @country.articles
  end
end
