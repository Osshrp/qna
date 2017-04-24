require 'rails_helper'

feature 'Questions list', %q{
  In order to find the required answer,
  the user should have the opportunity
  to view the list of questions
} do
  given!(:questions) { create_list(:question, 2) }
  given(:user) { create(:user) }

  scenario 'Authenticated user views list of questions' do
    sign_in(user)
    visit questions_path

    expect(page).to have_content questions.first.title
    expect(page).to have_content questions.last.title
  end

  scenario 'Unauthenticated user views list of question' do
    visit questions_path
    expect(page).to have_content  questions.first.title
    expect(page).to have_content questions.last.title
  end
end
