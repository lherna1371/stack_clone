class Question < ActiveRecord::Base
	belongs_to :user
	has_many :comments, dependent: :destroy

  has_many :answers, dependent: :destroy

	has_many :favorite_questions, dependent: :destroy
  has_many :favorited_by, through: :favorite_questions, source: :user, dependent: :destroy
	
  validates_presence_of :title
	validates_presence_of :content
	validates_presence_of :user_id

  def self.search(search)
    if search
      where('title LIKE :word OR content LIKE :word', word: "%#{search.strip}%").to_a
    else
      all
    end
  end

  
end

