require "test_helper"

class Api::V1::PomodorosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @params = {
      task: 'some test task',
      notes: 'here are the notes for test task',
      date: Date.new,
      user_id: users(:test_user)[:id]
    }
    token = JWT.encode({user_id: users(:test_user)[:id]}, Rails.configuration.jwt_secret)
    @headers = {
      "Authorization": "Bearer #{token}"
    }
  end

  test "it should have a pom index route" do
    get api_v1_pomodoros_path, headers: @headers, xhr: true

    assert_response :success
    assert_equal "application/json", @response.media_type
    json_response = JSON.parse(@response.body)
    assert_not_empty json_response
  end

  test "should create a new pom" do
    post api_v1_pomodoros_path, params: @params, headers: @headers, xhr: true

    assert_response :success
    assert_equal "application/json", @response.media_type
    json_response = JSON.parse(@response.body)
    assert_equal @params[:task], json_response['task']
  end

  test "should update a pom with a put" do
    @params[:task] = "new task"
    put api_v1_pomodoro_path pomodoros(:test_pom), params: @params, headers: @headers, xhr: true

    assert_response :success
    assert_equal "application/json", @response.media_type
    json_response = JSON.parse(@response.body)
    assert_equal "new task", json_response['task']
  end

  test "should update a pom with a patch" do
    @params[:task] = "some new task"
    patch api_v1_pomodoro_path pomodoros(:test_pom), params: @params, headers: @headers, xhr: true

    assert_response :success
    assert_equal "application/json", @response.media_type
    json_response = JSON.parse(@response.body)
    puts json_response
    assert_equal "some new task", json_response['task']
  end

  test "it should delete a pom" do
    delete api_v1_pomodoro_path pomodoros(:test_pom), headers: @headers, xhr: true

    assert_response :success
    assert_equal "application/json", @response.media_type
    json_response = JSON.parse(@response.body)
    assert_equal "pomodoro deleted", json_response['message']
  end
end
