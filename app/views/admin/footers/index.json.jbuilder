json.array!(@footers) do |footer|
  json.extract! footer, :image
  json.url footer_url(footer, format: :json)
end
