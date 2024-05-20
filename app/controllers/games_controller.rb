require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = Array.new(10) { ('A'..'Z').to_a.sample }
  end

  def check
    check = URI.open("https://dictionary.lewagon.com/#{params[:score]}").read
    check_serialized = JSON.parse(check)
    check_serialized['found']
  end

  def check_in_grid
    @answer.chars.all? { |letter| @answer.count(letter) <= params[:grid].count(letter) }
  end

  def result
    if check_in_grid && check
      @score_message = "Congratulations #{@answer} is a valid English word"
    elsif check_in_grid
      @score_message = "Sorry but #{@answer} can't be built out of #{params[:grid]}"
    else
      @score_message = "Sorry but #{@answer} does not seem to be a valid English word"
    end
  end

  def score
    @answer = params[:score].upcase
    check
    check_in_grid
    result
  end
end
