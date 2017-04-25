require 'rails_helper'

feature 'Author deletes question or answer', %q{
  Author can delete his question or answer
  but could not delete someone else's question or answer
} do

  given(:user) { create(:user) }
  given(:user_with_questions) { create(:user_with_questions) }
  given(:user_with_answers) { create(:user_with_answers) }
  given(:question) { create(:question) }
  given(:answer) { create(:answer) }

  scenario 'Author tries to delete his question' do
    sign_in(user_with_questions)

    visit question_path(user_with_questions.questions.first)
    click_on 'Delete question'

    expect(page).to have_content 'Your question successfully deleted'
    expect(page).to have_no_content 'MyString1'
  end

  scenario 'Author tries to delete his answer' do
    sign_in(user_with_answers)

    visit answer_path(user_with_answers.answers.first)
    click_on 'Delete answer'

    expect(page).to have_content 'Your answer successfully deleted'
    expect(page).to have_no_content 'AnswerText'
  end

  scenario 'Author tries to delete question that does not belongs to him' do
    sign_in(user)

    visit question_path(user_with_questions.questions.first)
    expect(page).to have_no_content 'Delete question'
  end
  scenario 'Author tries to delete answer that does not belongs to him' do
    sign_in(user)

    visit answer_path(user_with_answers.answers.first)
    expect(page).to have_no_content 'Delete answer'
  end

  scenario 'Unauthenticated user tries to delete question' do
    visit question_path(question)

    expect(page).to have_no_content 'Delete question'
  end

  scenario 'Unauthenticated user tries to delete answer' do
    visit answer_path(answer)

    expect(page).to have_no_content 'Delete answer'
  end
end
