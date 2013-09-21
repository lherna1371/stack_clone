class UpvoteAnswer < ActiveRecord::Base
	belongs_to :user
	belongs_to :answer
	validates_uniqueness_of :user, scope: :answer
end
