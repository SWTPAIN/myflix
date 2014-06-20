class Admin::VideosController < ApplicationController
  before_action :require_user
  before_action :require_admin

  def new
    @video = Video.new
  end

  def create
    @video = Video.new(video_params)
    if @video.save
      flash[:info] = "The video #{@video.title} is successfully added"
      redirect_to new_admin_video_path
    else
      flash[:danger] = "There are some problem in this video. Please check your input"
      render :new
    end
  end

  private

  def video_params
    params.require(:video).permit!
  end

  def require_admin
    unless current_user.admin?
      flash[:danger] = "You are not allowed to access it."
      redirect_to home_path
    end
  end

end
