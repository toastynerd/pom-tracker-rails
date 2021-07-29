require "test_helper"

class Api::V1::RegistrationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @params = {
      email: "controllertest@example.com", 
      password: "testpassword", 
      password_confirmation: "testpassword"
    }
  end
  test "it should have a signup route" do
    post api_v1_signup_path, params: @params, xhr: true
    assert_response :success
    assert_equal "application/json", @response.media_type
    json_response = JSON.parse(@response.body)
    assert_not_empty json_response[:jwt]
  end
end
