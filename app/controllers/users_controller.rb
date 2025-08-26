class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:show, :edit, :update]
  before_action :ensure_current_user!, only: [:edit, :update]
  
  def show
    @user  = User.find(params[:id])
    @books = @user.books
                  .includes(user: { profile_image_attachment: :blob })
                  .order(created_at: :desc)
  end

  def edit
  end

  def index
    @users = User.includes(profile_image_attachment: :blob).order(:id)
  end

  def update
    if @user.update(user_params)
      redirect_to @user, notice: "You have updated user successfully."
    else
     render :edit, status: :unprocessable_entity
    end
  end

  private
  def set_user
    @user = User.find(params[:id])
  end

  def ensure_current_user!
    redirect_to @user, alert: "権限がありません。" unless @user == current_user
  end

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end
end
