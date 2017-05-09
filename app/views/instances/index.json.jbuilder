json.array!(@instances) do |instance|
  json.extract! instance, :id, :ip_address, :image, :launch_time, :status
  json.url instance_url(instance, format: :json)
end
