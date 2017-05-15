class AddRatingToQuestions < ActiveRecord::Migration[5.0]
  def change
    add_column :questions, :rating, :integer, default: 0
    add_index :questions, :rating
  end
end
