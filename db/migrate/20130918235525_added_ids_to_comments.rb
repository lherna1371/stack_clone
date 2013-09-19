class AddedIdsToComments < ActiveRecord::Migration
  def up
    add_column :comments, :question_id, :integer
    add_column :comments, :answer_id, :integer
  end
end
