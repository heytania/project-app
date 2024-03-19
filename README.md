## Rails Intro Project

This Ruby on Rails project serves as a comprehensive platform to showcase articles. The articles are associated with authors, publishers, countries, and categories. It also provides a mechanism to search articles by title and filter them by category.

### Components:

1\. **Models**:\
    - **Author**: Contains information about the author.\
    - **Publisher**: Contains information about the publisher.\
    - **Article**: The main model containing details about the article, including title, link, published date, description, image URL, video URL, and language.\
    - **Category**: Categories under which articles are grouped.\
    - **Country**: Countries related to the articles.\
    - **ArticleCategory**: Intermediate model connecting articles and categories.\
    - **ArticleCountry**: Intermediate model connecting articles and countries.

2\. **Pages**:\
    - **Home**: Allows users to search for articles by title and filter them by category.\
    - **About**: Contains details about the platform.\
    - **Author Member Page**: Showcases all details related to a specific author.\
    - **Country Member Page**: Showcases all articles related to a specific country.

3\. **Search and Filtering**:\
    - The Home page has a search bar to search articles by their title.\
    - A dropdown to filter articles based on their category.

