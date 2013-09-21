class CreateDownvoteQuestion < ActiveRecord::Migration
  def change
    create_table :downvote_questions do |t|
    	t.integer :user_id
			t.integer :question_id
			t.timestamps
    end
  end
end
