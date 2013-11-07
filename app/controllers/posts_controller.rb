class PostsController < ApplicationController
  before_filter :require_user!

  def new
    @user = User.find(params[:user_id])
    @posts = @user.posts
    if @user == current_user
      render :new
    else
      flash[:errors] = ["You can only post to your own profile"]
      redirect_to user_url(@user)
    end
  end

  def create
    post = Post.new(params[:post])
    user = User.find(params[:user_id])

    unless user == current_user
      redirect_to user_url(user)
      return
    end

    post.user_id = params[:user_id]
    if post.save
      redirect_to user_url(user)
    else
      flash[:errors] = post.errors.full_messages
      redirect_to new_user_post_url(user_id: user.id)
    end
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy if post.user == current_user
    redirect_to user_url(id: params[:user_id])
  end
end
