class CreateArticleCategories < ActiveRecord::Migration
  def change
    create_table :article_categories do |t|
      t.string :name                        ,comment:"品目名称"
      t.string :desc										 ,comment:"描述"
      t.integer :position                  ,comment:"位置"

      t.timestamps
    end
    add_index :article_categories, :id
    add_index :article_categories, :name
    add_index :article_categories, :position
  end
end
