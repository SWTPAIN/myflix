class VideosController < ApplicationController
  before_action :require_user
  def index
   @categories = Category.all.order(:name)
  end

  def show
    @video = VideoDecorator.decorate(Video.find_by(slug: params[:id]))
    @reviews = @video.reviews
  end

  def search
    @search_result = Video.search_by_title(params[:search_term])
  end

end