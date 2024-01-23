class ApplicationController < ActionController::Base

  def index
    @tasks = Task.all
  end

  def new
    # render a new form
    # this could be @new_restaurant, we don't mind. Its just a convention to call them all the same
    @task = Task.new # creates a NEW EMPTY FORM
  end

  def create
    # create a new instance of restaurant
    @task = Task.new(task_params) # I can pass just :restaurant which is the entire HASH
    @task.save # Will raise ActiveModel::ForbiddenAttributesError
    # specify where to redirect the user after they submit
    redirect_to task_path(@task) # If i pass the entire @restaurant ruby is clever enough to get the id
  end

  def show
    @task = Task.find(params[:id])
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])
    @task.update(task_params) # Will raise ActiveModel::ForbiddenAttributesError
    redirect_to task_path(@task)
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    # No need for app/views/restaurants/destroy.html.erb
    redirect_to tasks_path, status: :see_other
  end

  private

  # Strong params: this is to permit to edit params via the form. We have to use strong params
  def task_params
    params.require(:task).permit(:title, :details, :completed)
  end

end
