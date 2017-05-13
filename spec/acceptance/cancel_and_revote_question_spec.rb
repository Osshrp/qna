require_relative 'acceptance_helper.rb'

feature 'Cancel vote and re-vote for question', %q{
  In order to fix mistake
  As an authenticated user
  Id like to be able to cancel vote and re-vote for question
} do
  scenario 'authenticated user cnacel vote and re-vote for question'
  scenario 'anorher user tries to cancel vote for question'
  scenario 'unauthenticated user tries to cancel vote for question'
end
