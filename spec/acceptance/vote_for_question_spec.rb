require_relative 'acceptance_helper.rb'

feature 'Vote for question', %q{
  In order to rate question
  As an authenticated user
  Id like to be able to vote for question
} do

  given(:user) { create(:user) }
  given(:question) { create(:question) }

  scenario 'authenticated user votes for question' do
    sign_in(user)
    visit question_path(question)
    within '.vote' do
      click_on 'Like'
      expect(page).to have_content 'You like it'
      expect(page).to have_content 'Recall vote'
    end


  end
  scenario 'authenticated user tries to vote for question once more time'
  scenario 'author tries to vote for his question'
  scenario 'unauthenticated user rires to vote for question'
end
