#frozen_string_literal: true

require_relative 'game'

def main
  words = load_words

  display_welcome_message
  choice = gets.chomp.downcase

  game = choice == 'load' ? load_game : Game.new(words.sample)
  game.play
end

def display_welcome_message
  welcome_message =  
    "Welcome to hangman\n"\
    'Enter load to continue a saved game or '\
    'press Enter to start a new game'
  puts welcome_message
end
