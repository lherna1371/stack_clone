class Question < ActiveRecord::Base
	belongs_to :user
	has_many :comments
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

