require_relative 'acceptance_helper.rb'

feature 'Add files to answer', %q{
  In order to illustrate my answer
  As an answers author
  Id like to be able to attache files
} do

  given(:user) { create(:user) }
  given(:question) { create(:question) }

  background do
    sign_in(user)
    visit question_path(question)
  end
  scenario 'User adds file when answers' do
    fill_in 'Your answer', with: 'Answer body'
    attach_file 'File', "#{Rails.root}/spec/spec_helper.rb"
    click_on 'Create'

    within '.answers' do
      expect(page).to have_link 'spec_helper.rb',
        href: '/uploads/attachment/file/1/spec_helper.rb'
    end
  end
end
