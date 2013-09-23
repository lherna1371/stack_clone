describe AuthenticationController do

	context 'POST to create' do
			before do 
				get :create,
			end

			it 'loads the answer to send the comment post' do
				expect(assigns(:resource)).to eq answer
			end	
	end

end


