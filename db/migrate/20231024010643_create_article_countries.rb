class CreateArticleCountries < ActiveRecord::Migration[7.0]
  def change
    create_table :article_countries do |t|
      t.references :article, null: false, foreign_key: true
      t.references :country, null: false, foreign_key: true

      t.timestamps
    end
  end
end
