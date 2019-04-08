class ApiController < TeamController
  protect_from_forgery
  
  rescue_from ActiveRecord::RecordNotFound, with: :render_json_404
  
  def render_json_404
    render status: 404, json: { status: 404, message: "見つかりませんでした。"}
  end

  def response_internal_server_error
    render status: 500, json: { status: 500, message: 'エラーが発生しました。' }
  end
end