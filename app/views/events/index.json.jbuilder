json.array!(@events) do |event|
  json.extract! event, :title, :college
  json.url event_url(event, format: :json)
end