class AddUserIdToSubscriptions < ActiveRecord::Migration[5.0]
  def change
    add_belongs_to :subscriptions, :user
    add_belongs_to :subscriptions, :question
  end
end
