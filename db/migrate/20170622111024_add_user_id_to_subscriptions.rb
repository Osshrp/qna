class AddUserIdToSubscriptions < ActiveRecord::Migration[5.0]
  def change
    add_belongs_to :subscriptions, :user, foreign_key: true
    add_belongs_to :subscriptions, :question, foreign_key: true
  end
end
