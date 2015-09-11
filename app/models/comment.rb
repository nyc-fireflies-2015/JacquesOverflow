class Comment < ActiveRecord::Base
	validates_presence_of :content

	belongs_to :commentable, polymorphic: true
	belongs_to :commentator, class_name: :User
end
