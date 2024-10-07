class TasksController < ApplicationController
  before_action :set_task, only: [ :show, :edit, :update, :destroy, :toggle_is_completed ]

  def index
    @tasks = Task.all
  end

  def show
  end

  def new
    @task = Task.new
    @categories = Category.all
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to tasks_path, notice: "Task was successfully created."
    else
      render :new
    end
  end

  def edit
    @categories = Category.all
  end

  def update
    if @task.update(task_params)
      redirect_to tasks_path, notice: "Task was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_path, notice: "Task was successfully deleted."
  end

  def toggle_is_completed
    @task.complete? ? @task.incomplete! : @task.complete!
    render json: { success: true, status: @task.status }
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :description, :status, :category_id)
  end
end
