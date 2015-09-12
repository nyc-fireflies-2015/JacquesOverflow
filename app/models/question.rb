class Question < ActiveRecord::Base

	validates_presence_of :content, :title
	validates :title, length: {maximum: 150}
	validates :content, length: {maximum: 5000}

	belongs_to :submitter, class_name: :User
	has_many :answers
	has_many :comments, as: :commentable
	has_many :votes, as: :voteable

	def rating
		votes.pluck(:value).reduce(:+) || 0
	end	
end
