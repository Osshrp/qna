require_relative 'acceptance_helper.rb'

feature 'Deletes files from question', %q{
  In order fix mistake
  As an questions author
  Id like to be able to delete attached files
} do

  given(:user) { create(:user) }
  given(:question) { create(:question) }

  describe 'User tries to delete file from question', js: true do
    background do
      sign_in(user)
      visit question_path(question)

      attach_file 'File', "#{Rails.root}/spec/spec_helper.rb"
      click_on 'Create'
    end
    scenario 'Author deletes file from question' do
      visit question_path(question)
      within '.question-attachments' do
        click_on 'delete file'

        expect(page).to have_no_link 'spec_helper.rb'
      end
    end
  end
end
