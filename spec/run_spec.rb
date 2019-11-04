require 'spec_helper'
require_relative "../config/environment.rb"

describe '../bin/run.rb' do
    context '#refresh' do
        it "clears the terminal view" do
            expect(refresh).to eq(system.("clear"))
        end
    end
    
    context '#welcome_menu' do
        it "prompts user to create a new user or to log in" do
            expect(greeting).to eq("What would you like to do?")
        end
    end
end
