class TasksController < ApplicationController
  before_action :set_task, only: [ :show, :edit, :update, :destroy, :toggle_is_completed ]

  def index
    @tasks = Task.all

    if params[:category_id].present?
      @tasks = @tasks.where(category_id: params[:category_id])
    end

    if params[:status].present?
      @tasks = @tasks.where(status: params[:status])
    end

    if params[:sort_by].present? && params[:sort_order].present?
      @tasks = @tasks.order("#{params[:sort_by]} #{params[:sort_order]}")
    end

    @categories = Category.all
  end

  def show
  end

  def new
    @task = Task.new
    @categories = Category.all
  end

  def create
    @task = Task.new(task_params)
    @categories = Category.all
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
    if params[:status].present? && Task.statuses.keys.include?(params[:status])
      @task.update(status: params[:status])
      flash[:notice] = "Status updated successfully"
    else
      flash[:alert] = "Invalid status"
    end

    redirect_to tasks_path
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :description, :status, :category_id)
  end
end
