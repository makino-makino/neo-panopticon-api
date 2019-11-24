class Post < ApplicationRecord
  belongs_to :user

  def self.tl(tl, users, numbers, start_id, start_created)

    if numbers >= Post.count 
      numbers = Post.count
      count = Post.count
    else
      count = numbers * 2
    end

    posts = where('id >= ? and created_at >= ?', start_id, start_created)
            .where(id: users.select('id'))
            .last(count)

    # 各投稿の評価値(投稿の新しさ * evaluation)と対応するインデックスをvaluesにしまう
    # 2要素の配列の配列
    values = []
    i = 0
    posts.each do |post|
      values[i] = [Evaluation.eval_post(post) * Evaluation.eval_user(post.user) * (i + 1), post]
      i += 1
    end

    if tl == "local"
      evals_counts = Evaluation.where(user_id: users).group(:post_id).count(:post_id)
      evals_ids = evals_counts.values.sort.reverse
      x = i / 2

      evals_counts.keys.each do |id|
        post = Post.find(id)
        values.push [Evaluation.eval_post(post) * Evaluation.eval_user(post.user) * (x + 1), post]
        posts.push post
      end
    end

    # valuesを評価値に基づいてソート→必要な数を取り出す→二つ目の要素を順にpostsに入れる
    posts = values.sort
                  .map{ |x| x[1] }
                  .reverse
                  .uniq
                  .first(numbers)
                  .sort
                  .reverse


    return posts

    # where('id >= ? and created_at >= ?', start_id, start_created)
    # .where(id: users)
    # .first(numbers)


  end

end
