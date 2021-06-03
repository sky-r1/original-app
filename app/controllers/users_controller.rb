class UsersController < ApplicationController
  
  # reCAPTCHA
  # prepend_before_action :check_captcha, only: [:create]
  
  before_action :require_user_logged_in, only: [:index, :show, :edit, :update, :destroy, :followings, :followers]
  
  def index
    @users = User.order(id: :desc).page(params[:page]).per(25)
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.order(id: :desc).page(params[:page])
    counts(@user)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = 'ユーザを登録しました。'
      redirect_to login_path
    else
      flash.now[:danger] = 'ユーザの登録に失敗しました。'
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
    unless @current_user == @user
      redirect_to root_url
    end
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = "プロフィールは正常に更新されました"
      redirect_to @user
    else
      flash.now[:danger] = "プロフィールは更新されませんでした"
      render :edit
    end
  end
  
  def destroy
    @current_user.destroy
        
    flash[:success] = "User は正常に削除されました"
    redirect_to root_url
  end
  
  def followings
    @user = User.find(params[:id])
    @followings = @user.followings.page(params[:page])
    counts(@user)
  end
  
  def followers
    @user = User.find(params[:id])
    @followers = @user.followers.page(params[:page])
    counts(@user)
  end
  
  private

  def user_params
    params.require(:user).permit(:name, :account, :intro, :birthday, :gender, :email, :phone, :img, :password, :password_confirmation)
  end
  
  # reCAPTCHA
  # def check_captcha
  #   if verify_recaptcha(model: @user)
  #     redirect_to login_path
  #   else 
  #     render 'new' 
  #   end
  # end

end
