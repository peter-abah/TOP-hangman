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
      prompt_to_save

      puts in_game_message
      letter = gets.chomp.downcase

      if letter == @hidden_word
        @won = true
      else
        @hidden_letters.include?(letter) ? @letters.add(letter) : @incorrect += 1
        @guessed.add(letter)
      end

      @won = true if @letters == @hidden_letters
    end
    puts end_game_message
  end

  def in_game_message
    dashed = []
    @hidden_word.each_char do |char|
      @letters.include?(char) ? dashed.push(char) : dashed.push('-')
    end
    "Guess a letter\n" \
      "#{dashed.join(' ')}\n" \
      "Incorrect : #{@incorrect}\n" \
      "Guessed Letters: #{@guessed.to_a.join(', ')}"
  end

  def end_game_message
    result = ''
    result += "You Won!\n" if @won
    result + "The word is #{@hidden_word.capitalize}"
  end

  def prompt_to_save
    puts 'Enter save to save game'
    choice = gets.chomp.downcase
    return unless choice == 'save'

    puts 'Enter name to save game as'
    file_name = "#{gets.chomp.downcase}.yaml"
    saved_game = YAML.dump(self)

    File.open(file_name, 'w') { |file| file.write(saved_game) }
  end
end
