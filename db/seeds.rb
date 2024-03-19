require 'csv'
require 'faker'

# Define the path to the CSV file
csv_file_path = Rails.root.join('news_sources.csv')

# Define a method to parse date strings from the CSV
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

# Read data from the CSV file and populate the database
CSV.foreach(csv_file_path, headers: true) do |row|
  # Find or create Author
  author = Author.find_or_create_by!(name: row['AUTHOR'])

  # Find or create Publisher
  publisher = Publisher.find_or_create_by!(name: row['PUBLISHER'])

  # Find or create Country
  country = Country.find_or_create_by!(name: row['COUNTRY'])

  # Find or create Category
  category = Category.find_or_create_by!(name: row['CATEGORY'])
  
  # Create or update Article
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

  # Create ArticleCountry association
  ArticleCountry.find_or_create_by!(article: article, country: country)
  
  # Create ArticleCategory association
  ArticleCategory.find_or_create_by!(article: article, category: category)
end

# Generate additional fake data using Faker gem
50.times do
  author = Author.find_or_create_by!(name: Faker::Name.name)
  publisher = Publisher.find_or_create_by!(name: Faker::Company.name)
  country = Country.find_or_create_by!(name: Faker::Address.country)
  category = Category.find_or_create_by!(name: Faker::Book.genre)

  article = Article.create!(
    title: Faker::Lorem.sentence,
    link: Faker::Internet.url,
    published_date: Faker::Time.between(from: DateTime.now - 365, to: DateTime.now),
    description: Faker::Lorem.paragraph,
    image_url: Faker::LoremPixel.image,
    video_url: Faker::Internet.url,
    language: Faker::Nation.language,
    author: author,
    publisher: publisher
  )

  # Assign random categories to the article
  article.categories << category

  # Assign random countries to the article
  article.countries << country
end

puts "Seeding completed!"
