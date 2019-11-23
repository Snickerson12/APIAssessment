require_relative '../db/seeds.rb'
require_relative '../lib/user_book.rb'

# menu class created to handle menu options and then required by run file
class Menu 

    def self.refresh
        system("clear")
    end
      
    def self.welcome_menu
      refresh
      while true
        greeting = "What would you like to do?"
        choice = PROMPT.select(greeting) do |menu|
          menu.choice "create new user", 1
          menu.choice "login", 2
          menu.choice "quit", 3
        end
        case choice
        when 1
          User.user_creation
        when 2
          User.login
        when 3
          exit
        end
      end
    end

    def self.main_menu
        refresh
        while true
          message = "What would you like to do?"
          choice = PROMPT.select(message) do |menu|
            menu.choice "search for a book", 1
            menu.choice "view my reading list", 2
            menu.choice "return to user login", 3
          end
          case choice
          when 1
            self.search_menu
          when 2
            UserBook.display_reading_list
          when 3
            welcome_menu
          end
        end
    end

    def self.search_menu
        refresh
        run_books
        search_options
    end
      
    def self.search_options
        while true
          message = "Add book to reading list or return to previous menu:"
          choice = PROMPT.select(message) do |menu|
            BOOKS_ARRAY.each do |book_obj|
              menu.choice book_obj[:title], book_obj
            end
            menu.choice "quit"
            BOOKS_ARRAY.clear
          end 
          if choice.is_a?(Book)
            UserBook.add_to_reading_list(choice)
          else 
            self.refresh
            break
          end
        end
    end


end