#frozen_string_literal: true

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
    until @won && @incorrect > 7
      puts in_game_message()
      letter = gets.chomp.downcase

      if letter == @hidden_word
        @won = true
      else
        hidden_letters.include?(letter) ? @letters.add(letter) : @incorrect += 1
        guessed.add(letter)
      end
      @won = true if letters == hidden_letters
    end
    puts end_game_message()
  end
end
