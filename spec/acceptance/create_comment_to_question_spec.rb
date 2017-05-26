require_relative 'acceptance_helper'

feature 'Create comment', %q{
  In order to clarify the issue,
  the user can create comments to question
} do

  given(:user) { create(:user) }
  given(:question) { create(:question, user: user) }

  context 'Authenticated user' do
    scenario 'tries to create comment to his quesiton' do
      visit question_path(question)
      within '.comments' do
        click_on 'New comment'
        fill_in 'Body', with: 'Text text'
        click_on 'Save'

        expect(page).to have_content 'Text text'
        expect(page).to have_not_button 'Save'
      end
    end
    scenario "tries to create comment to another user's question"
  end

  context 'multiple sessions' do
    scenario "comment appears on another user's page"
    scenario "comment appears on guest's page"
  end

  context 'Guest' do
    scenario 'tries to create comment to question'
  end
end
