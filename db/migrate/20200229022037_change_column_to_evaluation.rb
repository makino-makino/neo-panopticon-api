class ChangeColumnToEvaluation < ActiveRecord::Migration[5.2]
  def change
    remove_column :evaluations, :is_positive
    add_column :evaluations, :score, :integer
  end
end
