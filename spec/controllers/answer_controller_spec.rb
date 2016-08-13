describe AnswerController, type: :controller do
    let(:user) { FactoryGirl.create :user }
    let(:question) { FactoryGirl.create :question, user_id: user.id }

    before do
        sign_in user
    end

    describe "#load_question" do
        it "has response status 200" do
            get :load_question
            expect(response.status).to eq(200)
        end
        it "assign @question" do
            question = Question.all.sample(5)
            get :load_question
            expect(assigns(:question)).to be_present
        end
    end
    
    describe "#answer_check" do
        it "check if answer is right" do
            post :save_answer, answer: { question_id: question.id, user_id: user.id, answer: (question.answers.split(',').first) }
            expect(controller.answer_check).to be_truthy
        end
        
        it "check if answer is wrong" do
            post :save_answer, answer: { question_id: question.id, user_id: user.id, answer: "ahuy" }
            
            expect(controller.answer_check).to be_falsey
        end
    end
    
    describe "#save_answer" do
        it "redirect to answer result" do
            post :save_answer, answer: { question_id: question.id, user_id: user.id, answer: question.answers.split(',').first }

            expect(response.status).to eq(302)
        end

        it "save true to answer correct field" do
            post :save_answer, answer: { question_id: question.id, user_id: user.id, answer: question.answers.split(',').first }
            answer = Answer.last
            expect(answer.correct).to eq(true)
        end

        it "save false to answer correct field" do
            post :save_answer, answer: { question_id: question.id, user_id: user.id, answer: "ahoyyyy" }
            
            answer = Answer.last
            expect(answer.correct).to eq(false)
        end
    end
end
