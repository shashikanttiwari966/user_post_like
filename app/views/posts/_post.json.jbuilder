json.extract! post, :id, :references, :title, :description, :created_at, :updated_at
json.url post_url(post, format: :json)
