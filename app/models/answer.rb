class Answer < ActiveRecord::Base
	validates_presence_of :content
	validates :content, length: {maximum: 2000}

	has_many :comments, as: :commentable
	has_many :votes, as: :voteable
	belongs_to :responder, class_name: :User
	belongs_to :question

	def rating
		votes.pluck(:value).reduce(:+) || 0
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
