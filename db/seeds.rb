require 'csv'
require 'faker'

csv_file_path = Rails.root.join('news_sources.csv')

def parse_date(date_str)
  formats = [
    '%d-%m-%Y %H:%M:%S',
    '%Y-%m-%d %H:%M:%S'
  ]
  
  formats.each do |format_str|
    begin
      return DateTime.strptime(date_str, format_str)
    rescue Date::Error
      next
    end
  end
  nil
end


CSV.foreach(csv_file_path, headers: true) do |row|
  author = Author.find_or_create_by!(name: row['AUTHOR'])

  publisher = Publisher.find_or_create_by!(name: row['PUBLISHER'])

  country = Country.find_or_create_by!(name: row['COUNTRY'])

  category = Category.find_or_create_by!(name: row['CATEGORY'])
  

  article = Article.find_or_create_by!(link: row['ARTICLE LINK']) do |article|
    article.published_date = parse_date(row['PUBLISHED DATE (UTC)'])
    if article.published_date.nil?
        puts "Error parsing date for article #{row['TITLE']}: invalid date format >> #{row['PUBLISHED DATE (UTC)']}"
    end

    article.title = row['TITLE']
    article.description = row['DESCRIPTION'] || Faker::Lorem.paragraph
    article.image_url = row['IMAGE URL']
    article.video_url = row['VIDEO URL']
    article.language = row['LANGUAGE']
    article.author = author
    article.publisher = publisher
  end

  ArticleCountry.find_or_create_by!(article: article, country: country)
  ArticleCategory.find_or_create_by!(article: article, category: category)
end

puts "Seeding completed!"