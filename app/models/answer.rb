class Answer < ActiveRecord::Base
	has_many :comments, as: :commentable
	has_many :votes, as: :voteable
	belongs_to :responder, class_name: :User
	belongs_to :question
end
