require "open-uri"

class GamesController < ApplicationController
  def ask
    session[:start_time] = Time.now
    vowels = ["A", "E", "I", "O", "U", "Y"].sample(4)
    cons = Array.new(5) { ('A'..'Z').to_a.sample } - vowels
    grid = vowels << cons
    @grid = grid.flatten
  end

  def score
    end_time = Time.now

    @result = {
      score: 0,
      message: "",
    }

    if !included?(params[:word])
      @result[:message] = "Not in the grid"
    elsif !real_word?(params[:word])
      @result[:message] = "This is not an english word"
    else
      start_time = session[:start_time]
      @result[:score] = 1000 - (end_time - start_time.to_time)
      @result[:message] = "Bravo"
    end
  end

  private

  def real_word?(word)
    response = open("https://wagon-dictionary.herokuapp.com/#{word}").read
    formated_response = JSON.parse(response)
    formated_response['found']
  end

  def included?(word)
    word = word.upcase
    grid = params[:grid]
    word.chars.all? { |char| word.count(char) <= grid.count(char) }
  end
end
