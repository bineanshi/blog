class AddArticleUrlToArticle < ActiveRecord::Migration
  def change
    add_column :articles, :article_url, :string
  end
end
