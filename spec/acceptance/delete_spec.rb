require 'rails_helper'

feature 'Auther deletes question or answer', %q{
  Auther can delete his question or answer
  but could not delete someone else's question or answer
} do
  scenario 'Author try to delete his question'
  scenario 'Author try to delete his answer'
  scenario 'Author try to delete question that does not belongs to him'
  scenario 'Author try to delete answer that does not belongs to him'
end
