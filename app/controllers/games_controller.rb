require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = ('A'..'Z').to_a.sample(10)
  end

  def score
    @letters = params[:letters].upcase.split(' ')
    @answer = params[:answer].upcase.split('')

    @is_in_grid = included?(@answer, @letters)

    if @is_in_grid
      response = URI.open("https://dictionary.lewagon.com/#{params[:answer]}").read
      @valid = JSON.parse(response)['found']
    end

    @letters = params[:letters].upcase.split(' ')
    @answer = params[:answer].upcase

    # session[:score] += @answer.length if @valid
  end

  private

  def included?(word, letter_list)
    # tant que la première lettre du mot est dans la liste de lettre @letters
    while letter_list.include?(word[0])
      # enlever la première lettre du mot de la liste de lettre letter_list
      letter_list.delete(word[0])
      # supprimer la première lettre du mot
      word.delete_at(0)
    end
    # si toutes les lettres ont été supprimées alors le joueur à gagné
    word.empty?
  end
end
