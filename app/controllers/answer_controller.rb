class AnswerController < ApplicationController
    before_action :answer_check, only: :save_answer
    before_action :authenticate_user!

    def load_question
        @answer = Answer.new
        @question = Question.all.sample(5)
        @form_url = test_answer_path
    end

    def save_answer
        current_user.answers.create(answer_params)
        redirect_to test_result_path
    end
    
    def result
    end

    def answer_check
        question_id = answer_params[:question_id]
        question = Question.find(question_id)
        question_answers = question.answers.split(',')

        if question_answers.include?(answer_params[:answer])
            return params[:answer]["correct"] = true
        end

        return params[:answer]["correct"] = false
    end
    
    private
    
    def answer_params
        params.require(:answer).permit(:id, :question_id, :answer, :user_id, :correct)
    end

    def question_params
        params.require(:question).permit(:id, :question, :answers, :user_id)
    end
end
