class ApplicationController < ActionController::Base

  rescue_from StandardError, with: :notify_standard
  rescue_from ActiveRecord::RecordNotFound, with: :render_json_404

  def after_sign_in_path_for(resource_or_scope)
    home_path
  end

  # ログアウト後のリダイレクト先
  def after_sign_out_path_for(resource_or_scope)
    new_member_session_path
  end
  
  def render_json_404(e = nil)
    if e
      logger.info "Rendering 404 with exception: #{e.message}"
    end
  end

  def notify_standard(e = nil)
    if e
      logger.info "Rendering 500 with exception: #{e.message}"
      logger.error e.backtrace.join("\n")
      notifier = Slack::Notifier.new(Rails.application.config.slack_webhook_url)
      notifier.ping("-------------\n" + e.message + "\n" + e.backtrace.join("\n"))
    end
  end
end
