class User < ActiveRecord::Base
	has_secure_password

	validates_presence_of :username, :email, :password
	validates_uniqueness_of :username, :email
	validates_email_format_of :email, :message => 'is not in the correct format'
	validates :username, :email, :avatar_url, length: {maximum: 50}
	validates :bio, length: {maximum: 500}
	validates :password, length: {minimum: 6}

	has_many :questions, foreign_key: :submitter_id
	has_many :answers, foreign_key: :responder_id
	has_many :comments, foreign_key: :commentator_id
	has_many :votes, foreign_key: :voter_id
end
