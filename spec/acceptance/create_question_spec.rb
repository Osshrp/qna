require 'rails_helper'

feature 'Create question', %q{
  In order to get answers form community
  as an authenticated user
  I need to be able to ask questions
} do

  given(:user) { create(:user) }

  scenario 'Authenticated user create question' do

    sign_in(user)

    visit questions_path
    click_on 'Ask question'
    fill_in 'Title', with: 'Question title'
    fill_in 'Body', with: 'text text'
    click_on 'Create'

    expect(page).to have_content 'Your question successfully created'
    expect(page).to have_content 'Question title'
    expect(page).to have_content 'text text'
  end
  scenario 'Unauthenticated user create question' do
    visit questions_path
    click_on 'Ask question'

    expect(page).to have_content 'You need to sign in or sign up before continuing'
  end
end
