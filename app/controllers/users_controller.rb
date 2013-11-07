class UsersController < ApplicationController
  before_filter :require_no_user!, only: [:new, :create]
  before_filter :require_user!, only: [:index, :show]

  def new
    render :new
  end

  def create
    user = User.new(params[:user])

    unless user.password_confirmed?
      flash[:errors] = ["Passwords don't match"]
      redirect_to new_user_url
      return
    end

    if user.save
      self.current_user = user
      redirect_to root_url
    else
      flash[:errors] = user.errors.full_messages
      redirect_to new_user_url
    end
  end

  def index
    @friends = current_user.friends
    @users = User.alphabetize_users
    render :index
  end

  def show
    @user = User.find(params[:id])
    @posts = Post.sort_posts(@user.posts)
    render :show
  end
end
