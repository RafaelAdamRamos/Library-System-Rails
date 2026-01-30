class ApplicationController < ActionController::Base
  include Authentication
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  # Changes to the importmap will invalidate the etag for HTML responses
  stale_when_importmap_changes

   helper_method :current_user, :logged_in?

  private

  def logged_in?
    current_user.present?
  end

  def current_user
    Current.user
  end

  def require_admin
    unless current_user&.admin?
      redirect_to root_path, alert: "Você não tem permissão para acessar essa página."
    end
  end

  def require_login
    unless logged_in?
      redirect_to root_path, alert: "Você precisa estar logado para acessar essa página."
    end
  end
end
