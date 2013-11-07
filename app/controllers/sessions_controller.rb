class SessionsController < ApplicationController
  before_filter :require_no_user!, only: [:create, :new]
  before_filter :require_user!, only: [:destroy]

  def create
    user = User.find_by_credentials(
      params[:user][:username],
      params[:user][:password]
    )

    if user.nil?
      flash[:errors] = ["Credentials were wrong"]
      redirect_to new_session_url
    else
      self.current_user = user
      redirect_to root_url
    end
  end

  def destroy
    logout!
    redirect_to root_url
  end

  def new
    render :new
  end
end
