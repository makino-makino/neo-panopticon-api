class CreateFollowings < ActiveRecord::Migration[5.2]
  def change
    create_table :followings do |t|
      t.references :from_id, foreign_key: { to_table: :users }, null: false
      t.references :to_id, foreign_key: { to_table: :users }, null: false
      t.timestamps
    end
  end
end
