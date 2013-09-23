require 'spec_helper'

describe Authentication do
  	
	let(:user){User.create!(handle: 'Javier', email: 'javier@dev.com', password: '1234', password_confirmation:'1234')}

  	it "belongs to a user" do  
		auth = user.authentications.create(provider: 'twitter', uid: 2)
		expect(auth.user.handle).to eq 'Javier'
	end
end

