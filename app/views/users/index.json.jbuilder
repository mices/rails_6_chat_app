json.array!(@users) do |user|
  json.extract! user, :id, :temp
  json.url user_url(user, format: :json)
end
