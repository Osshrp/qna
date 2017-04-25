module AcceptanceHelper
  def sign_in(user)
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_on 'Log in'
  end

  def ask_question_link
    visit questions_path
    click_on 'Ask question'
  end

  def visit_and_check_question
    visit question_path(answer.question)

    expect(page).to have_content 'MyText'
    expect(page).to have_content 'AnswerText'
    expect(page).to have_content 'MyString1'
  end
end
