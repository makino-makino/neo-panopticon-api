json.extract! user, :id, :name, :bio, :icon, :evaluation
# :id, :name, :image, :created_at, :updated_at, :bio
json.evaluation @score
json.url user_url(user, format: :json)
