class Comment < ActiveRecord::Base
	belongs_to :commentable, polymorphic: true
	belongs_to :commentator, class_name: :User
end
