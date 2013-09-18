class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
    	t.integer :user_id
      t.text :content
      t.integer :up_votes
      t.integer :down_votes
      t.string :title

      t.timestamps
    end
  end
end
