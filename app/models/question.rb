class Question < ActiveRecord::Base
	belongs_to :user
	has_many :comments
	validates_presence_of :title
	validates_presence_of :content
	validates_presence_of :user_id
end
