class ArticleCategory < ActiveRecord::Base
	has_many :articles
	validates :name, uniqueness: true,presence: true
end
