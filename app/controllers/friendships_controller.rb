class FriendshipsController < ApplicationController
  before_filter :require_user!

  def create
    friendship = Friendship.new(
      user1_id: current_user.id,
      user2_id: params[:user_id]
    )

    friendship.create_two_friendships
    redirect_to user_url(id: params[:user_id])
  end

  def destroy
    friendship = Friendship.find(params[:id])
    friendship.destroy_two_friendships
    redirect_to user_url(id: params[:user_id])
  end
end
