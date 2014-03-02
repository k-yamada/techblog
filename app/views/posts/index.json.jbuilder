json.array!(@posts) do |post|
  post.keyword = @keyword
  json.extract! post, :id, :sub_id, :title, :body, :body_html, :updated_at, :created_at, :created_at_fmt, :tags
  json.url post_url(post, format: :json)
end