class ToppagesController < ApplicationController
  def index
    if logged_in?
      @comment = current_user.comments.build
      @posts = current_user.feed_posts.order(id: :desc).page(params[:page])
    end
  end
end
