class CreateDownvoteAnswers < ActiveRecord::Migration
  def change
    create_table :downvote_answers do |t|
    	t.integer :user_id
    	t.integer :answer_id
      t.timestamps
    end
  end
end
