json.extract! article, :id, :title, :tabloid, :author_name, :content, :submited_at, :is_publish, :desc, :article_category_id, :source_category_name, :created_at, :updated_at
json.url article_url(article, format: :json)
