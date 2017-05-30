require_relative 'acceptance_helper'

feature 'Create comment', %q{
  In order to clarify the answer,
  the user can create comments to answer
} do

  given(:user) { create(:user) }
  given(:question) { create(:question, user: user) }
  given!(:answer) { create(:answer, question: question, user: user) }
  given(:another_user) { create(:user) }

  context 'Authenticated user' do
    scenario 'tries to create comment to his answer', js: true do
      sign_in(user)
      visit question_path(question)
      within ".answer-#{answer.id}-comments" do
        click_on 'New comment'
        fill_in 'Comment body', with: 'Text text'
        click_on 'Save comment'

        expect(page).to have_content 'Text text'
        expect(page).to have_no_button 'Save comment'
      end
    end
    scenario "tries to create comment to another user's answer"
  end

  context 'multiple sessions' do
    scenario "comment appears on another user's page"
    scenario "comment appears on guest's page"
  end

  context 'Guest' do
    scenario 'tries to create comment to answer'
  end
end
