describe Question do
	let(:question) { FactoryGirl.create(:contact)}

	describe "#get_questions" do
		it "is return all question data " do
			question_all = Question.get_questions
			expect(question_all.count).to eq(Question.count)
		end		
	end
end
