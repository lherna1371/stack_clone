class RemoveUpvoteTable < ActiveRecord::Migration

	def change
		revert do
			create_table(:upvote) do |t|
				t.integer :user_id
				t.integer :question_id
				t.timestamps
			end
		end
	end
end