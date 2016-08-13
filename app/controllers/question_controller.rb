class QuestionController < ApplicationController
    before_action :authenticate_user!
    before_action :load_question, except: [:create, :new, :index, :destroy]

    def index
        @questions = Question.get_questions
    end

    def new
        @question = Question.new
        @form_url = question_index_path
    end
    
    def create
        current_user.questions.create(question_params)
        redirect_to question_index_path
    end

    def edit
        @form_url = question_path
    end

    def destroy
        Question.destroy(params[:id]) if params[:id]
        redirect_to question_index_path
    end

    def update
        @question.update(question_params)
        redirect_to question_index_path
    end

    private
    
    def load_question
        @question = Question.find params[:id]
    end
    def question_params
        params.require(:question).permit(:id, :question, :answers, :user_id)
    end
end
