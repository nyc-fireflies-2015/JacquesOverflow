class User < ActiveRecord::Base
	has_secure_password

	has_many :questions, foreign_key :submitter_id
	has_many :answers, foreign_key :responder_id
	has_many :comments, foreign_key :commentator_id
	has_many :votes, foreign_key :voter_id
end
