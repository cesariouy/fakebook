class FeedsController < ApplicationController
  before_filter :require_user!

  def show
    unsorted_friends_posts = grab_friends_posts(current_user)
    @friends_posts = Post.sort_posts(unsorted_friends_posts)
    render :show
  end

  private
  def grab_friends_posts(user)
    posts = []
    friends = user.friends.includes(:posts)

    friends.each do |friend|
      friend.posts.each do |post|
        posts << post
      end
    end

    posts
  end
end
