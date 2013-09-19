module QuestionHelper
	def two_questions
		a = Question.create!(:user_id => 1, :title => 'Test1', :content => 'content 1')
    b = Question.create!(:user_id => 1, :title => 'Test2', :content => 'content 2')
  	[a, b]
  end
end