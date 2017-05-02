require_relative 'acceptance_helper'

feature 'Answer editing', %q{
  In order to fix mistake
  as an author of answer
  I'd like to be able to edit answer
} do

  given(:user) { create(:user) }
  given(:question) { create(:question) }
  given!(:answer) { create(:answer, question: question, user: user) }

  scenario 'Unuthenticated user tries to edit answer' do
    visit question_path(question)

    expect(page).to_not have_link 'Edit'
  end
  scenario 'Author sees answer edit link' do
    sign_in(user)
    visit question_path(question)
    within '.answers' do
      expect(page).to have_link 'Edit'
    end
  end
  scenario 'Author tries to edit his answer'
  scenario "Authenticated user tries to edit other user's answer"
end
