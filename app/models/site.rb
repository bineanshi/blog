class Site < ActiveRecord::Base
	has_many :site_rules

	validates :search_url, uniqueness: true


	before_save :default_value
	def default_value
		self.main_url = search_url.split(/\//)[0] + "//" + search_url.split(/\:\/\//)[-1].split(/\//)[0]
	end
end
