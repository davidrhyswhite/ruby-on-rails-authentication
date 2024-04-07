module Authenticable
  extend ActiveSupport::Concern

  included do
    before_action :require_session
    helper_method :current_user
    helper_method :signed_in?
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def signed_in?
    !!current_user
  end

  def create_session(user)
    session[:user_id] = user.id.to_s
    @current_user = user
  end

  def destroy_session
    reset_session
    @current_user = nil
  end

  protected

  def require_session
    return if signed_in?

    not_authenticated
  end

  private

  def not_authenticated
    redirect_to sign_in_path, notice: I18n.t("sessions.notices.unauthorised")
  end
end
