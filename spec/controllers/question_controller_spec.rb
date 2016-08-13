describe QuestionController, type: :controller do
    let(:user) { FactoryGirl.create(:user) }
    let(:question) { FactoryGirl.create(:question, user_id: user.id) }
    
    describe "#index" do
        it "has response status 200" do
            sign_in user
            get :index
            
            expect(response.status).to eq(200)
        end
        
        it "has retrive data from question table" do
            expect(Question.get_questions).to be_truthy
        end
    end

    describe "#new" do
        it "has response status 200" do
            sign_in user
            get :new
            expect(response.status).to eq(200)
        end
    end

    describe "#edit" do
        it "has response status 200" do
            sign_in user
            get :edit , id: question.id
            expect(response.status).to eq(200)
        end

        it "do retrive data" do
            sign_in user
            get :edit, id: question.id
            q = Question.find(question.id)
            expect(q.id).to eq(question.id)
            expect(q.question).to eq(question.question)
            expect(q.answers).to eq(question.answers)
        end
    end
    
    describe "#delete" do
        it "redirect to question index" do
            sign_in user
            delete :destroy, id: question.id   
            expect(response.status).to eq(302)
        end 
    end

    describe "#create" do
        it "has create new record" do
            sign_in user
            expect{ post :create,   question: {
                                                  question: "apa ? siapa? dimana?",
                                                  answers: "gak tau, gak tau, gak tau",
                                                  user_id: user.id
                                              }
            }.to change(Question, :count).by(1)
        
            qt = Question.last
            qt.reload
            
            expect(qt.question).to eq("apa ? siapa? dimana?")
            expect(qt.answers).to eq("gak tau, gak tau, gak tau")
        
            
        end
    end

    describe "#update" do
        it "success update a data" do
            sign_in user
            patch :update, id: question.id,  question: { question: "berubah", answers: "ubah" }
            question.reload
            expect(question.question).to eq("berubah")
            expect(question.answers).to eq("ubah")
            expect(response.status).to eq(302)
        end

    end
end
