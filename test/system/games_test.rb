require "application_system_test_case"

class GamesTest < ApplicationSystemTestCase
  test "going to /new gives us a new random grid to play with" do
    visit 'http://localhost:3000/games/new'
    assert test: "New game"
    assert_selector "span", count: 10
  end

  test "fill the form with a random word, click the play button, and get a message that the word is not in the grid" do
    visit 'http://localhost:3000/games/new'
    fill_in "answer", with: "Hello"
    click_button 'Play'
    assert_text "Sorry"
  end

  test "fill the form with a one-letter consonant word, click play, and get a message that the word is not a valid English word" do
    visit 'http://localhost:3000/games/new'
    first_letter = first('span').text
    fill_in "answer", with: first_letter
    click_button 'Play'
    assert_text "not a valid word"
  end
end
