class PostsController < ApplicationController
  
  before_action :require_user_logged_in
  before_action :correct_user, only: [:edit, :update, :destroy]
  
  def index
  end

  def show
  end

  def new
    @post = Post.new
  end

  def create
    # @post = Post.new(post_params)
    @post = current_user.posts.build(post_params)

    if @post.save
      flash[:success] = '投稿しました。'
      redirect_to root_url
    else
      flash.now[:danger] = '投稿に失敗しました。'
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.new(post_params)

    if @post.save
      flash[:success] = '投稿しました。'
      redirect_to root_url
    else
      flash.now[:danger] = '投稿に失敗しました。'
      render :edit
    end
  end

  def destroy
    @post.destroy
    flash[:success] = '投稿を削除しました。'
    redirect_back(fallback_location: root_path)
  end
  
  private

  def post_params
    params.require(:post).permit(:img, :content)
  end
  
  def correct_user
    @post = current_user.posts.find_by(id: params[:id])
    unless @post
      redirect_to root_url
    end
  end
  
end
