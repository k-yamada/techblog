json.array!(@settings) do |setting|
  json.extract! setting, :id, :title, :description, :language, :ga_tracking_code, :github_id
  json.url setting_url(setting, format: :json)
end
