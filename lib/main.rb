# frozen_string_literal: true

require_relative 'game'

def main
  words = load_words

  display_welcome_message
  choice = gets.chomp.downcase

  game = choice == 'load' ? load_game : Game.new(words.sample)
  game&.play
end

def display_welcome_message
  welcome_message =
    "Welcome to hangman\n"\
    'Enter load to continue a saved game or '\
    'press Enter to start a new game'
  puts welcome_message
end

def load_words
  words = File.read('5desk.txt').split("\n")
  words.select { |word| word.length >= 5 && word.length <= 12 }
end

def load_game
  if Dir.exist?('saved_games')
    display_saved_games

    file_name = "saved_games/#{gets.downcase.chomp}.yaml"
    if File.exist?(file_name)
      load_saved_game(file_name)
    else
      puts 'The selected file does not exist'
    end

  else
    puts 'No saved game availaible'
  end
end

def display_saved_games
  games = Dir.entries('saved_games').map { |file| file[0..-6] }

  puts 'The following games are availaible'
  puts games.join(', ')
  puts 'Choose one'
end

def load_saved_game(file_name)
  YAML.safe_load(File.read(file_name))
end

main
