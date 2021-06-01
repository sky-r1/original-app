class CommentsController < ApplicationController
  
  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy]
  
  def new
    @comment = Comment.new
  end

  def create
    @comment = current_user.comments.build(comment_params)

    if @comment.save
      flash[:success] = 'コメントしました。'
      redirect_back(fallback_location: root_path)
    else
      flash[:danger] = 'コメントは必ず100文字以内で入力してください。'
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    @comment.destroy
    flash[:success] = 'コメントを削除しました。'
    redirect_back(fallback_location: root_path)
  end
  
  private

  def comment_params
    params.require(:comment).permit(:content, :post_id, :user_id)
  end
  
  def correct_user
    @comment = current_user.comments.find_by(id: params[:id])
    unless @comment
      redirect_to root_url
    end
  end
  
end
