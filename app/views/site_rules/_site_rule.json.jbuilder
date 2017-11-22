json.extract! site_rule, :id, :site_id, :site_name, :rule_name, :rule_value, :created_at, :updated_at
json.url site_rule_url(site_rule, format: :json)
