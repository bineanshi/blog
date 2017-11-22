# encoding: utf-8
class Snatch

	DEFAULT_RULE = {
			title: {search: "h1"},
			source_category_name: {search: "div.letter",key: "：([\\s\\S]*)时间："},
			submited_at: {search: "div.letter", key: "时间：([\\s\\S]*)发布："},
			tabloid: {search: "div.Introduction"},
			content: {search: "div.show_table"}
		}

	DEFAULT_LINKS = {search: ".content", css: "li.lh26 a"}
	DEFAULT_IMAGES = {css: "img"}

	def self.search(site_rule = nil,search_key='',obj)
		# return false unless site_rule
		$site_rule = site_rule.presence || SiteRule.first
		
		url = $site_rule.site.search_url

		# links = @site_rule.links.presence || DEFAULT_LINKS

		search_key_ascii = CGI::escape(search_key)
		source_url = url.gsub(/{search_key_ascii}/,search_key_ascii)

		doc = Snatch.rc(source_url)
		css_links = Snatch.send("get_#{$site_rule.links.keys.join('_')}", doc, $site_rule.links)
		links = []
		css_links.each do |link|
			links << link["href"]
		end
		
		links.each do |css_link|
			Snatch.find_obj(css_link,$site_rule,obj)
		end
	end

	def self.find_obj(link,site_rule,obj_name)
		$site_rule = site_rule
		rule = $site_rule.rule_value
		doc_url = link.include?("http") ? link : "#{$site_rule.site.main_url}#{link}"
		doc = Snatch.rc(doc_url)

		obj_params = {}
		rule.keys.each do |key|
			obj_params[key] = Snatch.send("get_#{rule[key].keys.join('_')}#{ '_content' if key.to_s == 'content'}", doc, rule[key])
		end

		obj = obj_name.camelize.constantize.find_or_initialize_by(obj_params)
		obj.send("#{obj_name.downcase}_url=", doc_url)

		obj.save

		image_links = Snatch.send("get_#{$site_rule.images.keys.join('_')}_image", doc, $site_rule.images)
		image_links.each do |link|
			image_url = "#{site_rule.site.main_url}#{link["src"]}"
			Snatch.download_img(image_url,link["src"])
		end
	end

	def self.rc(url)
		doc = nil
		begin
			timeout(100) do
		     begin
		       html = RestClient.get(url)
					doc = Nokogiri::HTML(html)
		     rescue Exception => e
		       
		     end
			end
		rescue StandardError,Timeout::Error
			
		end
		return doc
	end

	def self.get_search(body, hash)
		body.search(hash[:search]).text().to_s.gsub('　','').gsub("\n",'')
	end
	def self.get_css(body, hash)
		body.css(hash[:css])
	end
	def self.get_css_image(body,image)
		body.css(image[:css])
	end
	def self.get_search_css_image(body,image)
		body.search(image[:search]).css(image[:css])
	end
	def self.get_search_content(body, hash)
		body.search(hash[:search]).to_s.gsub('　','').gsub("\n",'')
	end

	def self.get_search_css(body, hash)
		body.search(hash[:search]).css(hash[:css])
	end

	def self.get_search_key(body, hash)
		content = body.search(hash[:search]).text().to_s.gsub('　','').gsub("\n",'')
		regex = Regexp.new(hash[:key])
		content.scan(regex) ? $1.strip : ''		
	end

	def self.download_img(image_url,path)
		begin
			img_file = RestClient.get(image_url)

			file_name = image_url.split('/').last
			all_path = path.split(file_name)[0].split('/')
			path_name = "public/"
			all_path.each do |path_arr|
				next if path_arr.blank?
				path_name += "#{path_arr}/"
				Dir.mkdir(path_name) unless File.exist?(path_name)
			end
			path_name = "#{path_name}#{file_name}"
			open(path_name, "wb") { |f| f.write(img_file) }
		rescue => err
			puts err
		end
	end
end
