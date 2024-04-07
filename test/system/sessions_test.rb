require "application_system_test_case"

class SessionsTest < ApplicationSystemTestCase
  setup do
    @user = users(:one)
  end

  test "sign in user" do
    visit sign_in_path

    assert_current_path "/sign-in"

    assert_selector "h2", text: "Sessions#new"

    within("form") do
      fill_in "Email", with: @user.email
      fill_in "Password", with: "topsecret"
      click_on "Sign in"
    end

    assert_text "Signed in successfully."
  end
end
