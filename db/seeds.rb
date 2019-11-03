# THIS IS WHERE WE GET API DATA
require 'rest-client'
require 'json'
require 'pry'
require_relative "../config/environment.rb"

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
        render_book_info(book)
    end
end

def render_book_info(book)
    puts "-" * 30
    puts "Title: " + book["volumeInfo"]["title"]
    book["volumeInfo"]["authors"].each {|author| puts "Author: " + author}
    puts "Publisher: " + book["volumeInfo"]["publisher"]
end
  
def run_books
    search = user_search_term
    books = get_books(search)
    render_all_books(books)
end

  
