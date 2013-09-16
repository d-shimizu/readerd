json.array!(@entries) do |entry|
  json.extract! entry, :feed_id, :title, :url, :summary, :published_at
  json.url entry_url(entry, format: :json)
end
