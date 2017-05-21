class ChangeValueToInteger < ActiveRecord::Migration[5.0]
  def change
    remove_column :votes, :value
    add_column :votes, :value, :integer
  end
end
