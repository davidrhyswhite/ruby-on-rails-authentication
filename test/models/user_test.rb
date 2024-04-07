require "test_helper"

class UserTest < ActiveSupport::TestCase
  def setup
    @user = users(:one)
  end
  test "user is valid" do
    assert_predicate @user, :valid?
  end

  test "name is not be blank" do
    @user.name = ""

    assert_not @user.valid?
  end

  test "name does not exceed 150 characters" do
    @user.name = "a" * 151

    assert_not @user.valid?
  end

  test "email is not be blank" do
    @user.email = ""

    assert_not @user.valid?
  end

  test "email is unique and case insensitive" do
    @user = User.new(name: "David", email: "david@example.com",
                     password: "topsecret", password_confirmation: "topsecret")
    @user.save

    assert_not @user.dup.valid?
  end

  test "email is downcased automatically before save" do
    @user.email = "DAVID@EXAMPLE.COM"
    @user.save

    assert_equal "david@example.com", @user.email
  end

  test "email does not exceed 320 characters" do
    name = "a" * 309
    @user.email = "#{name}@example.com"

    assert_not @user.valid?
  end

  test "email validity" do
    test_cases = %w[sample-@invalid.com sample..abc@invalid.com .sample@invalid.com sample#sample@invalid.com]

    test_cases.each do |email|
      @user.email = email

      assert_not @user.valid?
    end
  end
  test "password is not be blank" do
    @user = User.new name: "David", email: "david@example.com", password: "", password_confirmation: ""

    assert_not @user.valid?
  end

  test "password confirmation matches password" do
    @user = User.new name: "David", email: "david@example.com", password: "topsecret",
                     password_confirmation: "secrettop"

    assert_not @user.valid?
  end

  test "password length no greater than 73 characters" do
    password = "*" * 74
    @user = User.new name: "David", email: "david@example.com", password:,
                     password_confirmation: password

    assert_not @user.valid?
  end

  test "password length no less than 8 characters" do
    password = "*" * 7
    @user = User.new name: "David", email: "david@example.com", password:,
                     password_confirmation: password

    assert_not @user.valid?
  end
end
