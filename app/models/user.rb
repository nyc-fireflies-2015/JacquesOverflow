class User < ActiveRecord::Base
	has_secure_password

	validates_presence_of :username, :email
	validates_uniqueness_of :username, :email
	validates_email_format_of :email, :message => 'is not in the correct format'
	validates :username, :email, length: {maximum: 50}
	validates :avatar_url, length: {maximum: 500}
	validates :bio, length: {maximum: 500}
	validates :password, :presence => true, :length => {minimum: 6}, :on => :create

	has_many :questions, foreign_key: :submitter_id
	has_many :answers, foreign_key: :responder_id
	has_many :comments, foreign_key: :commentator_id
	has_many :votes, foreign_key: :voter_id

	def posted_question?(question)
		id == question.submitter.id
	end	

	def posted_answer?(answer)
		id == answer.responder.id
	end	

	def posted_comment?(comment)
		id == comment.commentator.id
	end	

	def voted_on_question?(question)
		votes.select {|vote| vote.voteable_type=="Question"}.map(&:voteable_id).include?(question.id)
	end
	
	def voted_on_answer?(answer)
		votes.select {|vote| vote.voteable_type=="Answer"}.map(&:voteable_id).include?(answer.id)
	end

	def authorized_to_vote_on_question?(question)
		!(posted_question?(question) || voted_on_question?(question))
	end
	
	def authorized_to_vote_on_answer?(answer)
		!(posted_answer?(answer) || voted_on_answer?(answer))
	end	

end
