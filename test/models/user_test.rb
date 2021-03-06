require "test_helper"

class UserTest < ActiveSupport::TestCase
  setup do
    @params = {
      email: "new_test@example.com",
      password: "testpassword",
      password_confirmation: "testpassword"
    }
  end

  test "it should save with valid parameters" do
    user = User.new(@params)
    assert user.save
  end

  test "should not save without an email" do
    @params.delete(:email)
    user = User.new(@params)
    assert_not user.save
  end

  test "should not save with a duplicate email" do
    @params[:email] = users(:test_user).email
    user = User.new(@params)
    assert_not user.save
  end

  test "should not save without an email that looks like an email" do
    @params[:email] = "test"
    user = User.new(@params)
    assert_not user.save
  end

  test "should not save without a password" do
    @params.delete(:password)
    @params.delete(:password_confirmation)
    user = User.new(@params)

    assert_not user.save
  end

  test "should have a method for token payload" do 
    user = users(:test_user)
    assert_not_nil user.to_token_payload
    assert_equal user.to_token_payload[:user_id], users(:test_user)[:id]
    assert_equal user.to_token_payload[:email], users(:test_user)[:email]
  end
end
