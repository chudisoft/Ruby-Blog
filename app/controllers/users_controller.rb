class UsersController < ApplicationController
  # Index action to list all users
  def index
    @users = User.all
  end

  # Show action to display a single user's profile
  def show
    @user = User.find(params[:id])
  end

  # New action to display the user creation form
  def new
    @user = User.new
  end

  # Create action to handle user creation
  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to @user, notice: 'User was successfully created.'
    else
      render 'new'
    end
  end

  # Edit action to display the user edit form
  def edit
    @user = User.find(params[:id])
  end

  # Update action to handle user updates
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to @user, notice: 'User was successfully updated.'
    else
      render 'edit'
    end
  end

  # Destroy action to delete a user
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to users_path, notice: 'User was successfully deleted.'
  end

  private

  def user_params
    params.require(:user).permit(:name, :photo, :bio)
  end
end
