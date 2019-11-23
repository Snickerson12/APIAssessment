require_relative '../config/environment'
require_relative '../db/seeds.rb'
require_relative 'menu.rb'
require "tty-prompt"
 
PROMPT = TTY::Prompt.new

def run
  Menu.welcome_menu
end

run