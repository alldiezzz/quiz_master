class Question < ApplicationRecord
    belongs_to :user
    has_one :answer

    def self.get_questions
        self.all
    end
end
