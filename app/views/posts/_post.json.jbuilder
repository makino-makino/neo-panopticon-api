json.extract! post, :id, :user_id, :content, :created_at, :updated_at
json.merge! @score
json.url post_url(post, format: :json)
