# json.extract! notification, :id, :updated_at
json.id notification["id"]
json.type notification["replied"]
json.updated_at notification["updated_at"]

content_id = notification["id"]

if notification["replied"] == "followed"
    following = Following.find(content_id)
    user = User.find(following.from_id)
    json.set! :user do
        json.id user.id
        json.name user.name
        json.bio  user.bio
        json.icon user.icon
        json.evaluation PostEvaluation.eval_user(user)
    end
else
    post = Post.find(content_id)
    json.set! :post do
        json.id post.id
        json.user_id post.user_id
        json.content post.content
        json.evaluation PostEvaluation.eval_post(post)
    end
end
