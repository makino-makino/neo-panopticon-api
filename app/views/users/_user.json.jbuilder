json.extract! user, :id, :bio, :image, :created_at, :updated_at
json.url user_url(user, format: :json)
