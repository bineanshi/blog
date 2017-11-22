class Article < ActiveRecord::Base
	belongs_to :article_category

	before_save :default_value
	def default_value
		self.article_category = ArticleCategory.find_or_create_by(name: self.source_category_name,desc: self.source_category_name)
	end

end
