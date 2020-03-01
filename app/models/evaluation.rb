class Evaluation < ApplicationRecord
  belongs_to :post
  belongs_to :user

  validates :score, numericality: { only_integer: true, greater_than_or_equal_to: -1, less_than_or_equal_to: 1}

  def self.eval_post(post)
    plus  = where('post_id = ? and score = 1', post.id).count
    minus = where('post_id = ? and score = -1', post.id).count

    if plus.zero? or minus.zero?
      plus += 1
      minus += 1
    end

    (plus / minus.to_f) ** 0.5
  end

  def self.eval_user(user)
    plus = includes(:post).where(
        score: 1,
        posts: { user_id: user.id }
    ).count()

    minus = includes(:post).where(
        score: -1,
        posts: { user_id: user.id }
    ).count()

    if plus.zero? or minus.zero?
      plus += 1
      minus += 1
    end

    (plus / minus.to_f) ** 0.5
  end
    
end
