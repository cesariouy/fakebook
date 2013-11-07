module SessionsHelper
  def current_user
    User.find_by_session(session[:token])
  end

  def current_user=(user)
    @current_user = user
    session[:token] = user.session
  end

  def logout!
    current_user.reset_session!
    session[:token] = nil
  end

  def require_user!
    redirect_to new_session_url if current_user.nil?
  end

  def require_no_user!
    self.logout! unless current_user.nil?
  end
end
