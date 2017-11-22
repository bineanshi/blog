class SiteRule < ActiveRecord::Base
	belongs_to :site
	serialize :rule_value, Hash
	serialize :links, Hash
	serialize :images, Hash
	before_save :default_value
	def default_value
		self.site_name = site.site_name
	end
end
