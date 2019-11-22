class CreateEvaluationFromPost < ActiveRecord::Migration[5.2]
  def change
    create_table :evaluations do |t|
      t.references :post, foreign_key: true
      t.integer :user_id
      t.boolean :is_positive
      t.timestamps
    end
  end
end
