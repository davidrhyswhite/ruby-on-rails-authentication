require "test_helper"

class SessionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
  end

  test "renders sign in page" do
    get sign_in_url

    assert_response :success
  end

  test "signs user in and redirects" do
    post sign_in_url, params: { email: @user.email, password: "topsecret" }

    assert_response :redirect
    assert_redirected_to private_path
  end

  test "renders sign in page when sign in fails" do
    post sign_in_url, params: { email: "unknown-user@example.com", password: "password" }

    assert_response :unprocessable_entity
  end

  test "should get destroy" do
    delete sign_out_url

    assert_response :redirect
    assert_redirected_to sign_in_path
  end
end
