class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.string :tag_name
      t.timestamps
    end
  end
end


class QuestionTag < ActiveRecord::Base
  belongs_to :question
  belongs_to :tag
end


(question)CreateQuestion model: 

  has_many :tags, :through => :question_tag
  has_many :question_tags

(tag)CreateTags model:

  has_many :posts, :through => :question_tag
  has_many :question_tags