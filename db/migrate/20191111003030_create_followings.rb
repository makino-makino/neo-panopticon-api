class CreateFollowings < ActiveRecord::Migration[5.2]
  def change
    create_table :followings do |t|
      t.references :from, foreign_key: { to_table: :users }, null: false
      t.references :to, foreign_key: { to_table: :users }, null: false
      t.timestamps
    end
  end
end
