describe QuestionController, type: :controller do
	let(:user) { FactoryGirl.create(:user) }
	let(:question) { FactoryGirl.create(:question, user_id: user.id) }

	describe "#index" do
		it "has response status 200" do
			get :index
			
			expect(response.status).to eq(200)
		end
		
		it "has retrive data from question table" do
			expect(Question.get_questions).to be_truthy
		end
	end

	describe "#new" do
		it "has response status 200" do
			get :new
			expect(response.status).to eq(200)
		end
	end

	describe "#edit" do
		it "has response status 200" do
			get :edit , id: question.id
			expect(response.status).to eq(200)
		end

		it "do retrive data" do
			get :edit, id: question.id
			q = Question.find(question.id)
			expect(q.id).to eq(question.id)
			expect(q.question).to eq(question.question)
			expect(q.answers).to eq(question.answers)
		end
	end
	
	describe "#delete" do
		it "has response status 320" do
			delete :destroy, id: question.id
			expect(response.status).to eq(302)
		end
		it "do delete a question" do
			delete :destroy , id: question.id
			expect(question).to eq(nil)
		end
	end
end
