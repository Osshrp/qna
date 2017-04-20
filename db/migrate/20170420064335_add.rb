class Add < ActiveRecord::Migration[5.0]
  def change
    add_belongs_to :answers, :question, index: true
  end
end
