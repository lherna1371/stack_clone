require 'spec_helper'

describe Authentication do
  	
	let(:user){User.create!(handle: 'Javier', email: 'javier@dev.com', password: '1234', password_confirmation:'1234')}

  	it "has an asisiacion whith user" do  
		auth = user.authentications.create(provider: 'twitter', uid: 2)
		expect(Authentication.last.provider).to eq 'twitter'
	end

	it "has an asisiacion whith user" do  
		auth = user.authentications.create(provider: 'twitter', uid: 2)
		expect(Authentication.last.provider).to eq 'twitter'
	end

end


