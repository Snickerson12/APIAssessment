class UserBook < ActiveRecord::Base
    belongs_to :user
    belongs_to :book

    # methods handling user-book reading list relations
    def self.add_to_reading_list(choice)
        user = File.read("userfile.txt")
        active_user = User.find_by(id: user)
        ub = UserBook.create(user_id: active_user.id, book_id: choice.id)
        Menu.refresh
        Menu.main_menu
    end

    def self.display_reading_list
        message = "Please enter your username:"
        username_lookup = PROMPT.ask(message, required: true, convert: :string)
        if username_lookup
          user_books = User.find_by(username: username_lookup).books
          Book.display_list_items(user_books)
        else
          puts "Invalid name"
        end
    end

end