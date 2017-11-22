json.extract! site, :id, :site_name, :search_url, :main_url, :created_at, :updated_at
json.url site_url(site, format: :json)
