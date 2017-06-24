require 'rails_helper'

feature 'View question', %q{
  In order to find an answer to question
  I need to be able to view question
  and answers to that question
} do
  given(:user) { create(:user) }
  given(:question) { create(:question_with_answers) }

  context 'Authenticated user' do
    before { sign_in(user) }
    scenario 'sees the question and answers to that question' do
      visit_and_check_question
    end

    scenario 'sees subscribe link' do
      visit question_path(question)

      expect(page).to have_link 'Subscribe'
    end

    scenario 'author does not see subscribe link'
    scenario 'if author hase unsubscribed, he see subscribe link'
  end

  context 'Unauthenticated user' do
    scenario 'sees the questions and answers to that question' do
      visit_and_check_question
    end

    scenario 'does not see subscribe link'
  end

  private

  def visit_and_check_question
    visit question_path(question)

    expect(page).to have_content 'MyString'
    expect(page).to have_content 'MyText'
    question.answers.each do |answer|
      expect(page).to have_content answer.body
    end

  end
end
