describe AnswerController, type: :controller do
    let(:user) { FactoryGirl.create :user }
    let(:question) { FactoryGirl.create :question, user_id: user.id }
    let(:answer) {FactoryGirl.create :answer, question_id: question.id, user_id: user.id, answer: "hahahaha"}

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
            expect(assigns(:questions)).to be_present
        end
    end
    
    describe "#answer_check" do
        it "check if answer is right" do
            post :save_answer, answer_par: { "1": (question.answers.split(',').first), "2": (question.answers.split(',').first) }, answer: {corect: nil}, question_ids: {"1": question.id, "2": question.id}
            expect(controller.answer_check(question.answers.split(',').first, question.id)).to be_truthy
        end
        
        it "check if answer is wrong" do
            post :save_answer, answer_par: { "1": "hahaha", "2": "hihi" }, answer: {question_id: question.id}, question_ids: {"1": question.id, "2": question.id}
            
            expect(controller.answer_check("ahuy", question.id)).to be_falsey
        end
    end
    
    describe "#save_answer" do
        it "redirect to answer result" do
            post :save_answer, answer_par: { "1": (question.answers.split(',').first), "2": (question.answers.split(',').first) }, answer: {question_id: question.id}, question_ids: {"1": question.id, "2": question.id}

            expect(response.status).to eq(302)
        end

        it "save true to answer correct field" do
            post :save_answer, answer_par: { "1": (question.answers.split(',').first), "2": (question.answers.split(',').first) }, answer: {question_id: question.id}, question_ids: {"1": question.id, "2": question.id}
            answer = Answer.last
            expect(answer.correct).to eq(true)
        end

        it "save false to answer correct field" do
            post :save_answer, answer_par: { "1": "hahaha", "2": "hihi" }, answer: {corect: nil}, question_ids: {"1": question.id, "2": question.id}
            
            answer = Answer.last
            expect(answer.correct).to eq(false)
        end
    end
    
    describe "#result" do
        it "has response 200" do
            get :result
            expect(response.status).to eq(200)
        end

        it "assign answers" do
            answers = answer
            get :result
            expect(assigns(:answers)).to be_present
        end
    end
end
