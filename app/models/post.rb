class Post < ApplicationRecord
  belongs_to :user

  def self.tl(users, numbers, start_id, start_created)

    if numbers >= Post.count 
      numbers = Post.count
      count = Post.count
    else
      count = numbers * 2
    end

    posts = where('id >= ? and created_at >= ?', start_id, start_created)
            .last(count)

    # 各投稿の評価値(投稿の新しさ * evaluation)と対応するインデックスをvaluesにしまう
    # 2要素の配列の配列
    values = []
    i = 0
    posts.each do |post|
      values[i] = [Evaluation.eval_post(post) * (i + 1), i]
      i += 1
    end

    # valuesを評価値に基づいてソート→必要な数を取り出す→二つ目の要素を順に@postsに入れる
    posts = values.sort
                  .last(numbers)
                  .map{ |x| posts[x[1]] }
                  .sort
                  .reverse


    return posts

    # where('id >= ? and created_at >= ?', start_id, start_created)
    # .where(id: users)
    # .first(numbers)


  end
end
