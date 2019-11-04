require 'spec_helper'
require_relative "../config/environment.rb"


describe User do

    it "has a username" do
        user = User.create(username: 'Mike')
        expect(user.username).to eq('Mike')
    end
end