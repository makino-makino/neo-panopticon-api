json.array! @posts do |post|
    json.id post.id
    json.user_id post.user_id
    json.content post.content
    json.source_id post.source_id
    json.created_at post.created_at
    json.updated_at post.updated_at

    post_evaluation = Evaluation.eval_post(post)
    user_evaluation = Evaluation.eval_user(post.user)
    count = (post.id - Post.last(20).first().id)

    json.evaluation post_evaluation
    json.user_evaluation user_evaluation
    json.count count

    json.total_evaluation (post_evaluation * user_evaluation * count)
end