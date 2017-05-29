require_relative 'acceptance_helper'

feature 'Create answer', %q{
  In order to answer to question
  beign on the question page,
  as an authenticated user
  I need to be able to create answer
} do

  given!(:user) { create(:user) }
  given(:question) { create(:question) }
  given(:users_question) { create(:question, user: user) }
  given(:another_user) { create(:user) }

  scenario 'Authenticated user answers the question', js: true do
    sign_in(user)
    visit question_path(question)
    fill_in 'answer_body', with: 'Answer text'
    click_on 'Create answer'

    expect(page).to have_content 'Answer text'
  end

  scenario 'Authenticated user tries to create invalid answer', js: true do
    sign_in(user)
    visit question_path(question)
    click_on 'Create answer'

    expect(page).to have_content "Body can't be blank"
  end

  scenario 'Unauthenticated user answers the question' do
    visit question_path(question)
    expect(page).to have_no_selector('input')
  end

  context 'multiple sessions' do
    scenario "answer appears on another user's page", js: true do
      Capybara.using_session('user') do
        sign_in(user)
        visit question_path(question)
      end

      Capybara.using_session('guest') do
        visit question_path(question)
      end

      Capybara.using_session('user') do
        fill_in 'answer_body', with: 'Answer text'
        click_on 'Create answer'

        expect(page).to have_content 'Answer text'
      end

      Capybara.using_session('guest') do
        expect(page).to have_content 'Answer text'
      end
    end

    scenario "author adds attaches to answer and it appears on another user's page"

    scenario "answer appears on question's author page with The best link", js: true do
      Capybara.using_session('user') do
        sign_in(another_user)
        visit question_path(users_question)
      end

      Capybara.using_session('questions_author') do
        sign_in(user)
        visit question_path(users_question)
      end

      Capybara.using_session('user') do
        fill_in 'answer_body', with: 'Answer text'
        click_on 'Create answer'

        expect(page).to have_content 'Answer text'
      end

      Capybara.using_session('questions_author') do
        expect(page).to have_content 'Answer text'
        expect(page).to have_link 'The best'
      end
    end
  end
end
