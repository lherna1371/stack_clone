require 'spec_helper'

describe User do
  	
	let(:user){User.create!(handle: 'Javier', email: 'javier@dev.com', password: '1234', password_confirmation:'1234')}

  	it "has many authentications" do  
		auth = user.authentications.create(provider: 'twitter', uid: 2)
		expect(Authentication.last.provider).to eq 'twitter'
	end
end