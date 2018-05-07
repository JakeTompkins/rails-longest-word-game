require 'open-uri'
require 'json'
class GamesController < ApplicationController
  def new
    @letters = ("a".."z").to_a.sample(10)
  end

  def check_valid(word)
    word.split('').each { |letter| return "#{word} uses letters not found in your list" if @letters.count(letter) < word.count(letter) }
    response = open("https://wagon-dictionary.herokuapp.com/#{word}").read
    json = JSON.parse(response)
    if json["found"] == true
      score = json["length"]
      return "Your score is #{score}"
    else
      return "That is not an english word!"
    end
  end

  def score
    @word = params[:word]
    @letters = params[:letters].split(' ')
    @message = check_valid(@word)
  end
end
