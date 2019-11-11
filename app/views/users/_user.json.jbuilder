json.extract! user, :id, :name, :bio, :image, :created_at, :updated_at
json.evaluation @score
json.url user_url(user, format: :json)
