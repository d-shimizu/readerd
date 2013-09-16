json.array!(@feeds) do |feed|
  json.extract! feed, :title, :url, :feed_url, :category_id, :last_modified
  json.url feed_url(feed, format: :json)
end
