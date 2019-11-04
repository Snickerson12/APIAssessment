require 'spec_helper'
require_relative "../config/environment.rb"


describe UserBook do

    it "assigned an id for both the associated user and book" do
        user_book = UserBook.create(user_id: 1, book_id: 1)
        expect(user_book.user_id).to eq(1)
        expect(user_book.book_id).to eq(1)
    end
end