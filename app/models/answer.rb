class Answer < ActiveRecord::Base
	validates_presence_of :content
	validates :content, length: {maximum: 2000}

	has_many :comments, as: :commentable
	has_many :votes, as: :voteable
	belongs_to :responder, class_name: :User
	belongs_to :question

	def rating
		votes.pluck(:value).reduce(:+)
	end	
end
