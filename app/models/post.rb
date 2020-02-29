class Post < ApplicationRecord
  belongs_to :user

  def self.local(user)
    followees = user.followees()
    followees_evaluations = Evaluation.where(user: followees, score: 1)
    return where(`id == or ? user == ? or user == self`, followees_evaluations.ids, followees, self)
  end

  def self.choose(posts)
    number = posts.count / 2
    pairs = []
    
    index = 0
    posts.each do |post|
      score = Evaluation.eval_post(post) * Evaluation.eval_user(post.user) * (index + 1) ** 2

      pair = [score, post]
      pairs.push pair
    end

    posts = pairs.sort
            .map{ |x| x[1] }
            .reverse
            .uniq
            .first(number)
            .sort
            .reverse

    return posts
  end
end
