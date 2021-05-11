#frozen_string_literal: true

class Game
  def initialize(word)
    @hidden_word = word
    @hidden_letters = Set.new(word.chars)
    @guessed = Set[]
    @letters = Set[]
    @won = false
  end
end
