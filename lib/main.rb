#frozen_string_literal: true

require_relative 'game'

def main
  words = load_words

  show_welcome_message
  choice = gets.chomp.downcase

  game = choice == 'load' ? load_game : Game.new(words.sample)
  game.play
end
