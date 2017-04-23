require 'rails_helper'

feature 'Question list', %q{
  In order to find the required answer,
  the user should have the opportunity
  to view the list of questions
} do
  scenario 'Authenticated user views list of question'
  scenario 'Unauthenticated user views list of question'
end
