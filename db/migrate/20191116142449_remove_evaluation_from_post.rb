class RemoveEvaluationFromPost < ActiveRecord::Migration[5.2]
  def change
    remove_column :posts, :evaluation
  end
end
