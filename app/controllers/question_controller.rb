class QuestionController < ApplicationController
    before_action :authenticate_user! 

    def index
        @questions = Question.get_questions
    end

    def new
        @question = Question.new
        @form_url = question_create_path
    end
    
    def create
       Question.create(question_params)
    end

    def edit
    end

    def destroy
        Question.destroy(params[:id]) if params[:id]
        redirect_to question_path
    end

    private
    def question_params
        params.require(:question).permit(:id, :question, :answers, :user_id)
    end
end
