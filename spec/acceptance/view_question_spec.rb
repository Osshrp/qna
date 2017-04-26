require 'rails_helper'

feature 'View question', %q{
  In order to find an answer to question
  I need to be able to viiew question
  and answers to that question
} do
  given(:user) { create(:user) }
  given!(:answer) { create(:answer) }
  given!(:question) { answer.question }

  scenario 'Authenticated user views the question and answers to that question' do
    sign_in(user)
    visit_and_check_question
  end
  scenario 'Unauthenticated user views the questions and answers to that question' do
    visit_and_check_question
  end

  private

  def visit_and_check_question
    visit question_path(answer.question)

    expect(page).to have_content 'MyText'
    expect(page).to have_content 'AnswerText'
    expect(page).to have_content 'MyString'
  end
end
