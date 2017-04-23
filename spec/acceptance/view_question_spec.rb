require 'rails_helper'

feature 'View question', %q{
  In order to find an answer to question
  I need to be able to viiew question
  and answers to that question
} do

  scenario 'Authenticated user views the question and answers'
  scenario 'Unauthenticated user views the questions and answers'
end
