class CreateUpvoteQuestions < ActiveRecord::Migration
  def change
    create_table :upvote_questions do |t|
    	t.integer :question_id
    	t.integer :user_id
      t.timestamps
    end
  end
end
