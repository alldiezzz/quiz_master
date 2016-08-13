class AnswerController < ApplicationController
    before_action :authenticate_user!

    def load_question
        @answer = Answer.new
        @questions = Question.all.sample(5)
        @form_url = test_answer_path
    end

    def save_answer
        count = 0
        params['answer_par'].map do |i,a|
            count += 1
            answer_check(a, params[:question_ids][count.to_s])
            current_user.answers.create(answer_params)
        end
        redirect_to test_result_path
    end
    
    def result
        @answers = current_user.answers
    end

    def answer_check(answer,question_id)
        question = Question.find(question_id)
        question_answers = question.answers.split(',')

        #if question_answers.include?(answer)
        #    correct = true
        #else
        #    correct = false
        #end

        question_answers.each do |question_answer|
            if question_answer.strip == answer
                @correct = true
                break
            else
                @correct = false
            end
        end
    
        assign_to_parameters(answer, question_id, @correct)
    end
    
    def assign_to_parameters(answer,question_id, correct)
        params[:answer]['answer'] = answer
        params[:answer]['question_id'] = question_id
        params[:answer]['correct'] = correct
    end
    
    private

    def answer_params
        params.require(:answer).permit(:id, :question_id, :answer, :user_id, :correct)
    end
end
