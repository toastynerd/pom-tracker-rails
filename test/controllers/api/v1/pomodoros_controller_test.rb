require "test_helper"

class Api::V1::PomodorosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @params = {
      task: 'some test task',
      notes: 'here are the notes for test task',
      date: Date.new
    }
  end

  test "it should have a pom index route" do
    get api_v1_pomodoros_path, xhr: true

    assert_response :success
    assert_equal "application/json", @response.media_type
    json_response = JSON.parse(@response.body)
    assert_not_empty json_response
  end

  test "should create a new pom" do
    post api_v1_pomodoros_path, params: @params, xhr: true

    assert_response :success
    assert_equal "application/json", @response.media_type
    json_response = JSON.parse(@response.body)
    assert_equal @params[:task], json_response['task']
  end

  test "should update a pom with a put" do
    @params[:task] = "new task"
    put api_v1_pomodoro_path pomodoros(:test_pom), params: @params, xhr: true

    assert_response :success
    assert_equal "application/json", @response.media_type
    json_response = JSON.parse(@response.body)
    assert_equal "new task", json_response['task']
  end

  test "should update a pom with a patch" do
    put api_v1_pomodoro_path pomodoros(:test_pom), params: {task: "some new task"}, xhr: true

    assert_response :success
    assert_equal "application/json", @response.media_type
    json_response = JSON.parse(@response.body)
    assert_equal "some new task", json_response['task']
  end

  test "it should delete a pom" do
    delete api_v1_pomodoro_path pomodoros(:test_pom), xhr: true

    assert_response :success
    assert_equal "application/json", @response.media_type
    json_response = JSON.parse(@response.body)
    assert_equal "pomodoro deleted", json_response['message']
  end
end
