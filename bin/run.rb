require_relative '../config/environment'
require_relative '../db/seeds.rb'
require "tty-prompt"
 
PROMPT = TTY::Prompt.new

def refresh
  system("clear")
end

def welcome_menu
  refresh
  greeting = "What would you like to do?"
  PROMPT.select(greeting) do |menu|
    menu.choice "create new user", 1
    menu.choice "login", 2
    menu.choice "quit", 3
  end
end

###### user creation/login menu options ##########

def user_creation
  refresh
  message = "Please enter a username to create an account."
  new_username_input = PROMPT.ask(message, required: true, convert: :string)
  create_user(new_username_input)
end

def create_user(new_username_input)
  new_user = User.find_or_create_by(username: new_username_input)
  main_menu
end

def login
  refresh
  message = "Please enter your username:"
  username_input = PROMPT.ask(message, required: true, convert: :string)
  locate_user(username_input)
end

def locate_user(username_input)
  user = User.find_by(username: username_input)
  if !user
    refresh
    puts "This account does not appear to exist"
  else
    File.open("userfile.txt", 'w') { |file| file.write(user.id.to_s) }
    main_menu
  end
end

###### search menu options ########

def main_menu
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
      search_menu
    when 2
      display_reading_list
    when 3
      break
    end
  end
end

############### search API #################

def search_menu
  refresh
  run_books
  search_options
end

def search_options
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
      add_to_reading_list(choice)
    else 
      refresh
      break
    end
  end
end

def add_to_reading_list(choice)
  user = File.read("userfile.txt")
  active_user = User.find_by(id: user)
  ub = UserBook.create(user_id: active_user.id, book_id: choice.id)
  refresh
  main_menu
end

########## view reading list ###############

def display_reading_list
  message = "Please enter your username:"
  username_lookup = PROMPT.ask(message, required: true, convert: :string)
  if username_lookup
    user_books = User.find_by(username: username_lookup).books
    display_list_items(user_books)
  else
    puts "Invalid name"
  end
end

def display_list_items(user_books)
  refresh
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

############### run method #################

def run
  while true
    welcome = welcome_menu
    case welcome
    when 1
      user_creation
    when 2
      login
    when 3
      break
    end
  end
end

run