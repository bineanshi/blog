class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :title                         ,comment:"标题"
      t.string :tabloid                       ,comment:"摘要"
      t.string :author_name                  ,comment:"作者"
      t.text :content                         ,comment:"文章内容"
      t.datetime :submited_at                ,comment:"发布时间"
      t.boolean :is_publish                  ,comment:"是否发布"
      t.string :desc                          ,comment:"备注"
      t.integer :article_category_id        ,comment:"分类ID"
      t.string :source_category_name        ,comment:"分类名称"
      t.string :article_url

      t.timestamps
    end
    add_index :articles, :id
    add_index :articles, :author_name
    add_index :articles, :is_publish
    add_index :articles, :title
    add_index :articles, :article_category_id
    add_index :articles, :source_category_name
    add_index :articles, :article_url
  end
end
