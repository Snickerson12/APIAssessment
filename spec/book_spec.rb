require 'spec_helper'
require_relative "../config/environment.rb"


describe Book do

    it "has a title" do
        book = Book.create(title: 'Dune')
        expect(book.title).to eq('Dune')
    end

    it "has an author" do
        book = Book.create(author: 'Frank Herbert')
        expect(book.author).to eq('Frank Herbert')
    end

    it "has a publisher" do
        book = Book.create(publisher: 'Chilton Books')
        expect(book.publisher).to eq('Chilton Books')
    end

end
  
 