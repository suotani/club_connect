class ApiController < TeamController
  protect_from_forgery
  
  rescue_from StandardError, with: :notify_standard
  rescue_from ActiveRecord::RecordNotFound, with: :render_json_404
  
  def render_json_404(e = nil)
    if e
      logger.info "Rendering 404 with exception: #{e.message}"
    end
    render status: 404, json: { status: 404, message: "見つかりませんでした。"}
  end

  def notify_standard(e = nil)
    if e
      logger.info "Rendering 500 with exception: #{e.message}"
      logger.error e.backtrace.join("\n")
      notifier = Slack::Notifier.new(Rails.application.config.slack_webhook_url)
      notifier.ping("-------------\n" + e.message + "\n" + e.backtrace.join("\n"))
    end
    render status: 500, json: { status: 500, message: 'エラーが発生しました。' }
  end
end