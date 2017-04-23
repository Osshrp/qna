require 'rails_helper'

feature 'User registrates', %q{
  In oder to sign in
  I need to be able to registrate in system
} do
  scenario 'Unregistered user try to registrate'
  scenario 'Registered user try to registrate'
end
