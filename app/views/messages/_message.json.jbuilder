json.extract! message, :id, :sender, :recipients, :content, :created_at, :updated_at
json.url message_url(message, format: :json)
