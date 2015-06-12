json.array!(@searches) do |search|
  json.extract! search, :id, :name, :latitude, :longitude
  json.url search_url(search, format: :json)
end
