require_relative 'acceptance_helper'

feature 'Create comment', %q{
  In order to clarify the answer,
  the user can create comments to answer
} do

  context 'Authenticated user' do
    scenario 'tries to create comment to his answer'
    scenario "tries to create comment to another user's answer"
  end

  context 'multiple sessions' do
    scenario "comment appears on another user's page"
    scenario "comment appears on guest's page"
  end

  context 'Guest' do
    scenario 'tries to create comment to answer'
  end
end
