json.array!(@admins) do |admin|
  json.extract! admin, :id, :title, :description, :language
  json.url admin_url(admin, format: :json)
end
