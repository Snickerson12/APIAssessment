# Get API Data
require 'rest-client'
require 'json'
require 'pry'
require_relative "../config/environment.rb"

BOOKS_ARRAY = []

def user_search_term
    puts "Please input your search terms"
    search_term = gets.chomp
end

def get_books(search_term)
    response = RestClient.get("https://www.googleapis.com/books/v1/volumes?q=#{search_term}&maxResults=5")
    book_data = JSON.parse(response)
end

def render_all_books(book_data)
    book_data["items"].collect do |book|
        create_book_object(book)
    end
end

def create_book_object(book)
    book_traits = {}
    title = book["volumeInfo"]["title"]
    author = book["volumeInfo"]["authors"]
    publisher = book["volumeInfo"]["publisher"]
    book_traits = {title: title, author: author, publisher: publisher}
    new_book = Book.create(book_traits)
    BOOKS_ARRAY << new_book
    render_book_info(book_traits)
end

def render_book_info(book_traits)
    puts "-" * 30
    puts "Title: " + book_traits[:title]
    book_traits[:author].each {|author| puts "Author: " + author}
    puts "Publisher: " + book_traits[:publisher]
end
  
def run_books
    search = user_search_term
    books = get_books(search)
    render_all_books(books)
end

  
