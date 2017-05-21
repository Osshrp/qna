class ChangeIsLikedtoValueInVotes < ActiveRecord::Migration[5.0]
  def change
    rename_column :votes, :is_liked, :value
    change_column :votes, :value, :string
  end
end
