class Question < ApplicationRecord
	belongs_to :user

	def self.get_questions
		self.all
	end
end
