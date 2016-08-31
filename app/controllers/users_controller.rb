class UsersController < ApplicationController
  before_action :find, only: [:edit, :update, :destroy]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to root_path
    else
      redirect_to new_user_path, notice: @user.errors
    end
  end

  def update
    if @user.update(user_params)
      redirect_to root_path
    else
      redirect_to edit_user_path(@user), notice: @user.errors
    end
  end

  def destroy
    @user.destroy
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :color)
  end

  def find
    @user = User.find(params[:id])
  end
end
