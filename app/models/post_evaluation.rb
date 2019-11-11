class PostEvaluation < ApplicationRecord
  belongs_to :post
  belongs_to :user

  def self.score(post)
    plus = where('post_id = ? and score = ?', post.id, 1).count()
    minus = where('post_id = ? and score = ?', post.id, 0).count()

    plus = 1.0 if plus.zero?
    minus = 1.0 if minus.zero?

    plus / minus
  end
end
