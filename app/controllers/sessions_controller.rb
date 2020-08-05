class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by email: params[:session][:email].downcase

    if user&.authenticate params[:session][:password]
      flash[:success] = t "session.success_login_notify"
      log_in user
      params[:session][:remember_me] == settings.validations.user.checkbox_value ? remember(user) : forget(user)
      redirect_to user
    else
      flash[:danger] = t "session.faild_login_notify"
      render :new
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
