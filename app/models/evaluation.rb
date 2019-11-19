class Evaluation < ApplicationRecord
  belongs_to :post
  belongs_to :user

  def self.eval_post(post)
    plus  = where('post_id = ? and is_positive = ?', post.id, true).count
    minus = where('post_id = ? and is_positive = ?', post.id, false).count

    if plus.zero? or minus.zero?
        plus += 1
        minus += 1
    end

    (plus / minus).to_f
  end

  def self.eval_user(user)

    plus = includes(:post).where(
        is_positive: true,
        posts: { user_id: user.id }
    ).count()

    minus = includes(:post).where(
        is_positive: false,
        posts: { user_id: user.id }
    ).count()

    plus = 1.0 if plus.zero?
    minus = 1.0 if minus.zero?

    plus / minus.to_f
  end
    
end
