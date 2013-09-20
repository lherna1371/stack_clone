module AnswerHelper
	def basic_setup
		user1 = User.create(:handle => 'handle1', :email => 'handle1@email.com', :admin => false, password: "password", password_confirmation: "password")
		user2 = User.create(:handle => 'handle2', :email => 'handle2@email.com', :admin => false, password: "password", password_confirmation: "password")
		user3 = User.create(:handle => 'handle3', :email => 'handle3@email.com', :admin => true, password: "password", password_confirmation: "password")

		q1 = user1.questions.create(:title => 'User 1 Title', :content => 'User 1 Content')
		q2 = user2.questions.create(:title => 'User 2 Title', :content => 'User 2 Content')

		q1.answers << user2.answers.create(:content => 'User 2 answer to Question 1')
	end
end