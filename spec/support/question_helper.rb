module QuestionHelper
	def two_posts
		Question.create!(:user_id => 1, :title => 'Test1', :content => 'content 1')
    Question.create!(:user_id => 1, :title => 'Test2', :content => 'content 2')
  end
end