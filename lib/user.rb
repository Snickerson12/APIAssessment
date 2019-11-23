class User < ActiveRecord::Base
    has_many :user_books
    has_many :books, through: :user_books


    # User methods moved from bin/run.rb to handle creation and login
    def self.create_user(new_username_input)
      new_user = User.find_or_create_by(username: new_username_input)
      Menu.main_menu
    end

    def self.user_creation
        Menu.refresh
        message = "Please enter a username to create an account."
        new_username_input = PROMPT.ask(message, required: true, convert: :string)
        create_user(new_username_input)
    end

    def self.login
        Menu.refresh
        message = "Please enter your username:"
        username_input = PROMPT.ask(message, required: true, convert: :string)
        locate_user(username_input)
    end
    
    def self.locate_user(username_input)
    user = User.find_by(username: username_input)
        if !user
            Menu.refresh
            puts "This account does not appear to exist"
        else
            File.open("userfile.txt", 'w') { |file| file.write(user.id.to_s) }
            Menu.main_menu
        end
    end
      

end