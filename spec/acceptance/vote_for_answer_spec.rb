require_relative 'acceptance_helper.rb'

feature 'Vote for answer', %q{
  In order to rate answer
  As an authenticated user
  Id like to be able to vote for answer
} do
  scenario 'authenticated user votes for answer'
  scenario 'author tries to vote for his answer'
  scenario 'unauthenticated user rires to vote for answer'
end
