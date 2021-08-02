require "test_helper"

class Api::V1::SessionsControllerTest < ActionDispatch::IntegrationTest
  setup do 
    @params = {
      email: users(:test_user).email,
      password: 'testpassword'
    }
  end

  test "it should be able to sign in to an existing user" do
    post api_v1_signin_path, params: @params, xhr: true
    assert_response :success 
    assert_equal "application/json", @response.media_type
    json_response = JSON.parse(@response.body)
    assert_not_empty json_response['token']
  end
end
