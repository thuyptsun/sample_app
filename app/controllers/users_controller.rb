class UsersController < ApplicationController
  before_action :logged_in_user, except: [:new, :show, :create]
  before_action :find_user, except: [:index, :new, :create]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: :destroy

  def index
    @users = User.page(params[:page]).per Settings.pagination
  end

  def new
    @user = User.new
  end

  def show; end

  def edit; end

  def create
    @user = User.new user_params
    if @user.save
      log_in @user
      flash[:success] = t "shared.signup_success"
      redirect_to @user
    else
      flash[:danger] = t "shared.signup_danger"
      render :new
    end
  end

  def update
    if @user.update user_params
      flash[:success] = t "edit.edit_success"
      log_in @user
      redirect_to @user
    else
      flash[:danger] = t "edit.edit_danger"
      render :edit
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = t "shared.user_deleted"
    else
      flash[:danger] = t "shared.delete_danger"
    end
    redirect_to users_url
  end

  private

  def find_user
    @user = User.find_by id: params[:id]
    return if @user
    
    flash[:danger] = t "shared.user_not_found"
    redirect_to root_url
  end

  def user_params
    params.require(:user).permit User::USER_PARAMS
  end

  def logged_in_user
    return if logged_in?

    flash[:danger] = t "login.login_danger"
    redirect_to login_url
  end

  def correct_user
    redirect_to root_url unless current_user?(@user)
  end

  def admin_user
    redirect_to root_url unless current_user.admin?
  end
end
