class Vote < ActiveRecord::Base
	validates_presence_of :value
	validates_inclusion_of :value, :in => [-1, 1]

	belongs_to :voteable, polymorphic: true
	belongs_to :voter, class_name: :User
end
