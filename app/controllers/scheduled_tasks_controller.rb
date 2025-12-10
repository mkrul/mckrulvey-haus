class ScheduledTasksController < ApplicationController
  def index
    @upcoming_tasks = ScheduledTask.upcoming.limit(10)
    @overdue_tasks = ScheduledTask.overdue
  end

  def new
    @scheduled_task = ScheduledTask.new(notify_minutes_before: 30)
  end

  def create
    @scheduled_task = ScheduledTask.new(scheduled_task_params)

    if @scheduled_task.save
      redirect_to scheduled_tasks_path, notice: "Task scheduled successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @scheduled_task = ScheduledTask.find(params[:id])
  end

  def update
    @scheduled_task = ScheduledTask.find(params[:id])

    if @scheduled_task.update(scheduled_task_params)
      redirect_to scheduled_tasks_path, notice: "Task updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @scheduled_task = ScheduledTask.find(params[:id])
    @scheduled_task.destroy
    redirect_to scheduled_tasks_path, notice: "Task removed."
  end

  private

  def scheduled_task_params
    params.require(:scheduled_task).permit(:title, :description, :due_at, :recurrence, :notify_minutes_before, :completed_at)
  end
end

