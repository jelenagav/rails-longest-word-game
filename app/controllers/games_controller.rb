class GamesController < ApplicationController

  def new
    @letters = Array.new(grid_size) { ('A'..'Z').to_a.sample }
  end

  # def score
  #   puts 'score' if params[:userinput] == @letters
  # end

  def english_word?(word)
    response = open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
  return json['found']
  end

  def included?(guess, grid)
    guess.chars.all? { |letter| guess.count(letter) <= grid.count(letter) }
  end

  def attempt
   @attempt = params[:attempt]
  end

end

# The word can't be built out of the original grid
# The word is valid according to the grid, but is not a valid English word
# The word is valid according to the grid and is an English word
