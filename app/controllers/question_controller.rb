class QuestionController < ApplicationController
	def index
		@questions = Question.get_questions
	end

	def new
	end
	
	def edit
	end

	def destroy
		question = Question.find(params[:id])
		question.destroy
		redirect_to question_path
	end
end
