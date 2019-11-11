class CreatePostEvaluations < ActiveRecord::Migration[5.2]
  def change
    create_table :post_evaluations do |t|
      t.references :post, foreign_key: true
      t.references :user, foreign_key: true
      t.float :score

      t.timestamps
    end
  end
end
