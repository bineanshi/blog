# encoding: utf-8
class Snatch2
	#return status 
	# error 100 无抓取链接
	# error 101 无抓取规则
	# error 200 抓取页面报错
	# error 201 抓取页面超时
	#
	# success 300 已解析页面
	# success 301 规则解析完毕
	@analy_result = {}
	@analy_doc = {}
	@status = []
	def initialize(url = nil, search_key = nil, options = nil)
		@status << {status: 100, msg: "无抓取链接"} if url.blank?
		@status << {status: 101, msg: "无抓取规则"} if options.blank?
		@search_key = search_key.present? ? CGI::escape(search_key) : ''
		@url = url.gsub(/{search_key_ascii}/,@search_key)
		@options = options
		check_rules
	end

	def status
		@status
	end

	def doc
		@doc ||= rc
	end

	def check_rules
		check = []
		check << "规则不是hash" unless @options.is_a?(Hash)
		@options.each do |key,rule|
			check << "#{key}不是hash" and next unless rule.is_a?(Hash)
			check << "#{key}无有效规则" and next if (rule.keys & ["css","regex","type"]).count < 1
			check << "#{key}规则有效"
		end
		@status << {status: 102, msg: check}
	end

	def analy
		analy_status = []
		@options.each do |key,rule|
			next unless rule.is_a?(hash)
			@analy_doc[key] ||= {doc: @doc}
			["search_css", "to_format", "search_regex"].each do |rule_key|
				next unless rule[rule_key].present?
				@analy_result[key] = send(rule_key,rule[rule_key])
			end
		analy_status << "#{key}规则已解析"
		end
		@status << {status: 301, msg:"规则解析完毕"}
	end

	def search_css(key ,search_css)
		@analy_doc[key][:analy_doc] = @analy_doc[key][:doc].search(search_css)
	end

	def to_format(key,type = nil)
		@analy_doc[key][:analy_doc] ||= @analy_doc[key][:doc]
		@analy_doc[key][:analy_doc] = case type
		when "text"
			@analy_doc[key][:analy_doc].text()
		when "to_s"
			@analy_doc[key][:analy_doc].to_s
		else
			@analy_doc[key][:analy_doc].to_s
		end
	end

	def search_regex(key ,search_key)
		regex = Regexp.new(search_key)
		@analy_doc[key][:analy_doc].to_s.gsub('　','').gsub("\n",'').scan(regex) ? $1.strip : ''	
	end

	def analy_rule(doc, rule)
		doc.
	end

	def rc
		@doc = nil
		begin
			timeout(100) do
		     begin
		       html = RestClient.get(@url)
					@doc = Nokogiri::HTML(html)
					@status << {status: 1024, msg:"已获取页面内容"}
		     rescue Exception => e
		       @status << {status: 200, msg: e}
		     end
			end
		rescue StandardError,Timeout::Error
			@status << {status: 201, msg: "抓取页面超时"}
		end
		return @doc
	end
	
end