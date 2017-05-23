class AddUserIdToVotes < ActiveRecord::Migration[5.0]
  def change
    add_belongs_to :votes, :user
    add_index :votes, [:votable_id, :votable_type]
  end
end
