class Book < ActiveRecord::Base
    has_many :user_books
    has_many :user, through: :user_books

    # methods handling display of fetched books 
    def self.display_list_items(user_books)
    Menu.refresh
    user_books.each do |book| 
        puts book.title
        puts book.author
        puts book.publisher
        puts "-" * 30
    end
    while true
        message = "Press any key to return to previous menu"
        PROMPT.keypress(message)
        break
    end
    end

end