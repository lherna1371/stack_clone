class Comment < ActiveRecord::Base
	belongs_to :answer
	belongs_to :question

	validates_presence_of :content
end
