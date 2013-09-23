class Question < ActiveRecord::Base
	belongs_to :user
	has_many :comments, dependent: :destroy

  has_many :answers, dependent: :destroy
  has_many :upvote_questions, dependent: :destroy
	has_many :downvote_questions, dependent: :destroy
	has_many :favorite_questions, dependent: :destroy
  has_many :favorited_by, through: :favorite_questions, source: :user, dependent: :destroy
  has_many :tags, through: :question_tags
  has_many :question_tags

  validates_presence_of :title
	validates_presence_of :content
	validates_presence_of :user_id

  def self.search(search)
    if search
      where('title LIKE ? OR content LIKE ?', "%#{search.strip}%", "%#{search.strip}%").to_a
    else
      all
    end
  end


end

