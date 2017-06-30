require_relative 'acceptance_helper.rb'

feature 'Search in questions', %q{
  In order to find question,
  I need to be able to search it
} do

  given!(:question) { create(:question, title: '111') }

  scenario 'User tries to search question by title' do
    visit questions_path
    fill_in 'Search', with: '111'
    select('questions', from: 'scope')
    click_on 'Find'

    expect(page).to have_link '111'
  end
end
