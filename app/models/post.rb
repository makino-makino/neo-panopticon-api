class Post < ApplicationRecord
  belongs_to :user

  def self.tl(users, numbers, start_id, start_created)

    if numbers >= Post.count then return Post.all end

    posts = where('id >= ? and created_at >= ?', start_id, start_created)
            .first(numbers * 2)

    # 各投稿の評価値(投稿の新しさ * evaluation)と対応するインデックスをvaluesにしまう
    # 2要素の配列の配列
    values = []
    (numbers * 2).times do |i|
      values[i] = [Evaluation.eval_post(posts[i]) * (numbers * 2 - i), i]
    end

    # valuesを評価値に基づいてソート→必要な数を取り出す→二つ目の要素を順に@postsに入れる
    posts = values.sort
                  .reverse
                  .first(numbers)
                  .map{ |x| x[1] }
                  .sort
                  .map{ |x| posts[x] }


    return posts

    # where('id >= ? and created_at >= ?', start_id, start_created)
    # .where(id: users)
    # .first(numbers)


  end
end
