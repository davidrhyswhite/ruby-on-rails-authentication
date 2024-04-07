require "test_helper"

class PrivateControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
  end

  test "renders index if user signed in" do
    create_user_session(@user)
    get private_url

    assert_response :success
  end

  test "redirects if user not signed in" do
    get private_url

    assert_response :redirect
  end
end
