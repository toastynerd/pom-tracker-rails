class Api::V1::PomodorosController < ApplicationController
  def index
    @poms = Pomodoro.all
    render json: @poms
  end

  def create
    @pom = Pomodoro.new(pomodoro_params)
    if @pom.save 
      render json: @pom
    else
      render json: @pom.errors
    end
  end

  def update
    @pom = Pomodoro.find(params[:id])
    if @pom.update(pomodoro_params)
      render json: @pom
    else
      render json: @pom.errors
    end
  end

  def destroy
    @pom = Pomodoro.find(params[:id])
    @pom.delete
    render json: {message: "pomodoro deleted"}
  end

  private
  def pomodoro_params
    params.permit(:task, :notes)
  end
end
