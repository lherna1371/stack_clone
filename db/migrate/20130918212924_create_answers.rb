class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
    	t.integer :user_id
      t.text :content
      t.integer :up_votes
      t.integer :down_votes
      t.integer :question_id
      t.boolean :solved

      t.timestamps
    end
  end
end
