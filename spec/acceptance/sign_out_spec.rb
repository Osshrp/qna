require 'rails_helper'

feature 'User sign out', %q{
  In oder to finish session
  I need to be able to sign out
} do
  scenario 'Authenticated user try to sign out'
  scenario 'Unauthenticated user try to sign out'
end
