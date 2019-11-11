class PostEvaluation < ApplicationRecord
  belongs_to :post
  belongs_to :user

  def self.eval_post(post)
    plus = where('post_id = ? and score = ?', post.id, 1).count()
    minus = where('post_id = ? and score = ?', post.id, 0).count()

    plus = 1.0 if plus.zero?
    minus = 1.0 if minus.zero?

    plus / minus.to_f
  end

  def self.eval_user(user)
    # TODO: 式はあとでちゃんと考える
    plus = includes(:post).where(
        score: 1,
        posts: { user_id: user.id }
    ).count()

    minus = includes(:post).where(
        score: 0,
        posts: { user_id: user.id }
    ).count()

    plus = 1.0 if plus.zero?
    minus = 1.0 if minus.zero?

    plus / minus.to_f
  end
    
end
