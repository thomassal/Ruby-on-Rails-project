json.array!(@properties) do |property|
  json.extract! property, :id, :varable, :value
  json.url property_url(property, format: :json)
end
