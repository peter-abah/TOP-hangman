#frozen_string_literal: true

require 'set'
require 'yaml'

class Game
  def initialize(word)
    @hidden_word = word
    @hidden_letters = Set.new(word.chars)
    @guessed = Set[]
    @letters = Set[]
    @won = false
    @incorrect = 0
  end

  def play
    until @won || @incorrect >= 7
      letter = prompt_for_input

      update_game_state(letter)

      puts in_game_message

      save_game if prompt_to_save == 'save'
    end

    puts end_game_message
  end

  def prompt_for_input
    puts "Guess a letter"
    gets.chomp.downcase
  end

  def update_game_state(letter)
    if letter == @hidden_word
      @won = true
    else
      @hidden_letters.include?(letter) ? @letters.add(letter) : @incorrect += 1
      @guessed.add(letter)
    end

    @won = true if @letters == @hidden_letters
  end

  def in_game_message
    dashed = []

    @hidden_word.each_char do |char|
      @letters.include?(char) ? dashed.push(char) : dashed.push('-')
    end

    "#{dashed.join(' ')}\n" \
      "Incorrect : #{@incorrect}\n" \
      "Guessed Letters: #{@guessed.to_a.join(', ')}"
  end

  def save_game
    Dir.mkdir('saved_games') unless Dir.exist?('saved_games')

    puts 'Enter name to save game as'
    file_name = "saved_games/#{gets.chomp.downcase}.yaml"
    saved_game = YAML.dump(self)

    File.open(file_name, 'w') { |file| file.write(saved_game) }
  end

  def prompt_to_save
    puts "\nEnter save to save game or enter any key to continue"
    gets.chomp.downcase
  end

  def end_game_message
    result = ''
    result += "You Won!\n" if @won
    result + "The word is #{@hidden_word.capitalize}"
  end
end
