json.array!(@headers) do |header|
  json.extract! header, :image
  json.url header_url(header, format: :json)
end
