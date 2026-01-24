module Authentication
  extend ActiveSupport::Concern

  included do
    class_attribute :unauthenticated_actions, default: []

    before_action :resume_session
    before_action :require_authentication
  end

  class_methods do
    def allow_unauthenticated_access(only:)
      self.unauthenticated_actions += Array(only).map(&:to_s)
    end
  end

  private

  def resume_session
    if (session_id = cookies.signed[:session_id])
      Current.session = UserSession.find_by(id: session_id)
      Current.user = Current.session&.user
    end
  end

  def require_authentication
    return if self.class.unauthenticated_actions.include?(action_name)
    redirect_to new_session_path unless Current.user
  end

  def start_new_session_for(user)
    user_session = user.user_sessions.create!(
      user_agent: request.user_agent,
      ip_address: request.remote_ip
    )

    Current.session = user_session
    Current.user = user

    cookies.signed.permanent[:session_id] = {
      value: user_session.id,
      httponly: true,
      same_site: :lax
    }
  end

  def terminate_session
    Current.session&.destroy
    cookies.delete(:session_id)
    Current.session = nil
    Current.user = nil
  end

  def after_authentication_url
    root_path
  end
end
