class AddRetweetColumnToPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :source_id, :integer
  end
end
