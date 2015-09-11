class Question < ActiveRecord::Base

	validates_presence_of :content, :title

	belongs_to :submitter, class_name: :User
	has_many :answers
	has_many :comments, as: :commentable
	has_many :votes, as: :voteable
end
