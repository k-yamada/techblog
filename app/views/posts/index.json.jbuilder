json.array!(@posts) do |post|
  json.extract! post, :id, :title, :body, :body_html, :updated_at, :created_at
  json.url post_url(post, format: :json)
end
