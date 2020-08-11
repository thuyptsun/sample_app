class FollowersController < ApplicationController
  before_action :logged_in_user
  before_action :find_user

  def index
    @title = t "user.stats.followers"
    return unless @user

    @users = @user.followers.page params[:page]
    render "users/show_follow"
  end
end
