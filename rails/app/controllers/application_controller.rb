class ApplicationController < ActionController::Base
  before_action :set_cache_buster
  # include ErrorHandle

  include AdminsAuth
  helper AdminsAuth

  protected
  # Called by sorcery
  def logged_in?
    current_user && current_user.undiscarded? && current_user.status_active?
  end

  # Called by sorcery
  def require_login
    unless logged_in?
      redirect_to login_path(redirect_to: request.fullpath)
    end
  end

  # override lib module
  # see: AdminsAuth::admin_logged_in?
  def admin_logged_in?
    admin_current_user && admin_current_user.undiscarded?
  end

  private
    def set_cache_buster
      response.headers["Cache-Control"] = "no-cache, no-store, max-age=0, must-revalidate"
      response.headers["Pragma"] = "no-cache"
      response.headers["Expires"] = "Fri, 01 Jan 1990 00:00:00 GMT"
    end
end
