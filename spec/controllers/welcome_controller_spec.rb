describe WelcomeController, type: :controller do
	describe "#index" do
		it "has response status 200" do
			get :index
			
			expect(response.status).to eq(200)
		end
	end
end
