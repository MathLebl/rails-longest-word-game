require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = [*('A'..'Z')].sample(10)
  end

  def score
    @word = params[:word].upcase
    @word_split = @word.split('')
    @letters_split = params[:letters].split('')
    diff = @word_split - @letters_split
    if diff == []
      if api(params[:word])
        @result = "Congratulations #{@word} is good and English"
      else
        @result = "Congratulation #{@word} is good but not English"
      end
    else
      @result = "Sorry #{@word} can't be build out of #{@letters_split.join(',')}"
    end
  end
  def api(word)
    url = open("https://wagon-dictionary.herokuapp.com/#{word}")
    result = JSON.parse(url.read)
    result["found"]
  end
end
