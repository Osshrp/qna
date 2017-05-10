require_relative 'acceptance_helper.rb'

feature 'Add files to question', %q{
  In order to illustrate my question
  As an questions author
  Id like to be able to attache files
} do

  given(:user) { create(:user) }

  describe 'User tries to add file to question' do
    background do
      sign_in(user)
      visit new_question_path
    end
    scenario 'Author adds file when asks question' do
      fill_in 'Title', with: 'Test question'
      fill_in 'Body', with: 'Question body'
      attach_file 'File', "#{Rails.root}/spec/spec_helper.rb"
      click_on 'Create'

      expect(page).to have_link 'spec_helper.rb',
        href: '/uploads/attachment/file/1/spec_helper.rb'
    end

    given(:question) { create(:question, user: user) }

    scenario 'Another user tries to add file to question' do
      click_on 'Sign out'
      visit question_path(question)

      within '.question' do
        expect(page).to have_no_selector('input')
      end
    end
  end
end
