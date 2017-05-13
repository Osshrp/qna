require_relative 'acceptance_helper.rb'

feature 'Cancel vote and re-vote for answer', %q{
  In order to fix mistake
  As an authenticated user
  Id like to be able to cancel vote and re-vote for answer
} do
  scenario 'authenticated user cnacel vote and re-vote for answer'
  scenario 'anorher user tries to cancel vote for answer'
  scenario 'unauthenticated user tries to cancel vote for answer'
end
