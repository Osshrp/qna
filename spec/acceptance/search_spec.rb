require_relative 'acceptance_helper'
require_relative '../support/sphinx_helper'

feature 'Search', %q{
  In order to find object,
  I need to be able to search it
} do

  given!(:question) { create(:question, title: "question's title") }
  given!(:answer) { create(:answer, body: "answer's body") }
  given!(:comment) { create(:comment, commentable: question,
    body: "comment's body") }
  # given!(:comment) { create(:comment, commentable: answer,
  #   body: "answer's comment body") }
  given!(:user) { create(:user, email: 'test@test.com') }

  background do
    index
    visit root_path
  end

  scenario 'User tries to search question title in all region', js: true do
    fill_in 'Search', with: "question's title"
    select('all', from: 'scope')
    click_on 'Find'

    expect(page).to have_link "question's title"
  end

  scenario 'User tries to search question title in question region', js: true do
    fill_in 'Search', with: "question's title"
    select('questions', from: 'scope')
    click_on 'Find'

    expect(page).to have_link "question's title"
  end

  scenario 'User tries to search answer body in answers region', js: true do
    fill_in 'Search', with: "answer's body"
    select('answers', from: 'scope')
    click_on 'Find'

    expect(page).to have_link "answer's body"
  end

  scenario 'User tries to search comment body in comments region', js: true do
    fill_in 'Search', with: "comment's body"
    select('comments', from: 'scope')
    click_on 'Find'

    expect(page).to have_link "comment's body"
  end

  scenario 'User tries to search user email in users region', js: true do
    fill_in 'Search', with: "test@test.com"
    select('users', from: 'scope')
    click_on 'Find'

    expect(page).to have_content "test@test.com"
  end
end
