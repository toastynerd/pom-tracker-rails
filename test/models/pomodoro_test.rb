require "test_helper"

class PomodoroTest < ActiveSupport::TestCase
  setup do
    @params = {
      task: 'a test task',
      notes: 'I done completed this task',
    }
  end

  test "it should save with valid parameters" do
    pom = users(:test_user).pomodoros.new(@params)
    assert pom.save
  end

  test "it should not save without a task" do
    @params.delete(:task)
    pom = Pomodoro.new(@params)

    assert_not pom.save
  end
end
