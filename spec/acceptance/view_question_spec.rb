require_relative 'acceptance_helper.rb'

feature 'View question', %q{
  In order to find an answer to question
  I need to be able to view question
  and answers to that question
} do
  given(:user) { create(:user) }
  given(:question) { create(:question_with_answers) }
  given(:authors_question) { create(:question, user: user) }

  context 'Authenticated user' do
    before { sign_in(user) }
    scenario 'sees the question and answers to that question' do
      visit_and_check_question
    end

    scenario 'sees subscribe link' do
      visit question_path(question)

      expect(page).to have_link 'Subscribe'
    end

    scenario 'author does not see subscribe link' do
      visit question_path(authors_question)

      expect(page).to_not have_link 'Subscribe'
      expect(page).to have_link 'Unsubscribe'
    end

    scenario 'if user has been unsubscribed, he see subscribe link' do
      visit question_path(authors_question)

      click_on 'Unsubscribe'
      expect(page).to have_link 'Subscribe'
      expect(page).to_not have_link 'Unsubscribe'
    end
  end

  context 'Unauthenticated user' do
    scenario 'sees the questions and answers to that question' do
      visit_and_check_question
    end

    scenario 'does not see subscribe link' do
      visit question_path(question)

      expect(page).to_not have_link 'Subscribe'
    end
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
