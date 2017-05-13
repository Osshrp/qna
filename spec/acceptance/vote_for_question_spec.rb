require_relative 'acceptance_helper.rb'

feature 'Vote for question', %q{
  In order to rate question
  As an authenticated user
  Id like to be able to vote for question
} do
  scenario 'authenticated user votes for question'
  scenario 'authenticated user tries to vote for question once more time'
  scenario 'author tries to vote for his question'
  scenario 'unauthenticated user rires to vote for question'
end
