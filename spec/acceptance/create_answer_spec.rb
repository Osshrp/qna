require 'rails_helper'

feature 'Create answer', %q{
  In order to answer to question
  beign on the question page,
  as an authenticated user
  I need to be able to create answer
} do
  scenario 'Authenticated user answers the question'
  scenario 'Unauthenticated user answers the questions'
end
