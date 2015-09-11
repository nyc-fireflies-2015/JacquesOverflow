class Answer < ActiveRecord::Base
	validates_presence_of :content

	has_many :comments, as: :commentable
	has_many :votes, as: :voteable
	belongs_to :responder, class_name: :User
	belongs_to :question
end
