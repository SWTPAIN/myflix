class Admin::VideosController < ApplicationController
  before_action :require_user
  before_action :require_admin

  def new
    @video = Video.new
  end

  private

  def require_admin
    unless current_user.admin?
      flash[:danger] = "You are not allowed to access it."
      redirect_to home_path
    end
  end

end
