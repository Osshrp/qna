require_relative 'acceptance_helper.rb'

feature 'Cancel vote and re-vote for question', %q{
  In order to fix mistake
  As an authenticated user
  Id like to be able to cancel vote and re-vote for question
} do

  given(:user) { create(:user) }
  given(:question) { create(:question) }
  given!(:another_user) { create(:user) }

  background do
    sign_in(user)
    visit question_path(question)
    within '.question' do
      choose 'Like'
      click_on 'Vote'
    end
  end
  scenario 'authenticated user cnacel vote and re-vote for question', js: true do
    within '.question' do
      click_on 'Recall vote'
      expect(page).to have_no_content "You've liked it"
      expect(page).to have_no_button 'Recall vote'
      expect(page).to have_button 'Vote'
    end
  end
  scenario 'anorher user tries to cancel vote for question', js: true do
    click_on 'Sign out'
    sign_in(another_user)
    visit question_path(question)
    within '.question' do
      expect(page).to have_no_button 'Recall vote'
    end
  end
  scenario 'unauthenticated user tries to cancel vote for question', js: true do
    click_on 'Sign out'
    visit question_path(question)
    within '.question' do
      expect(page).to have_no_button 'Recall vote'
    end
  end
end
