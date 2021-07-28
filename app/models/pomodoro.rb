class Pomodoro < ApplicationRecord
  validates :task, presence: true
end
