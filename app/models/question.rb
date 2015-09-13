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

	def votes_per_hour
		votes.select {|vote| vote.created_at < 1.hour.ago}.count
	end

	def self.order_by_recent
		self.order(created_at: :desc)
	end

	def self.order_by_trending
		self.all.sort {|q1, q2| q1.votes_per_hour <=> q2.votes_per_hour}
	end

	def self.order_by_votes
		self.all.sort {|q1, q2| q1.rating <=> q2.rating}
	end

	def timestamp
		milliseconds = self.created_at.to_i/1000
		seconds = milliseconds/1000
		minutes = seconds/60
		hours = minutes/60
		days = hours/24

		if minutes == 0
			return "#{seconds} seconds"
		elsif hours == 0
			return "#{minutes} minutes"
		elsif days == 0
			return "#{hours} hours"
		else
			return "#{days} days"
		end
	end

end
