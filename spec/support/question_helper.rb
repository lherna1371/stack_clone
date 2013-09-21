module QuestionHelper
	def two_questions
		d = User.create!(handle: "handle2",email: "test6@test.com",password: "password", password_confirmation: "password")
		c = User.create!(handle: "handle",email: "test5@test.com",password: "password", password_confirmation: "password")
		a = c.questions.create!(:title => 'Test1', :content => 'content 1',:up_votes => 0, :down_votes => 0)
    b = d.questions.create!(:title => 'Test2', :content => 'content 2',:up_votes => 0, :down_votes => 0)
  	[a, b]
  end

  def new_question
		visit new_question_path	
		fill_in 'question_title', with: 'Best Language?'
		fill_in 'question_content', with: "What's the best language?"
		click_button 'Create Question'	
  end
end