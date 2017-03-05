class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Token::ControllerMethods

  TOKEN = "secret"

  private
  def authenticate
    authenticate_or_request_with_http_token do |token, options|
      ActiveSupport::SecurityUtils.secure_compare(
          ::Digest::SHA256.hexdigest(token),
          ::Digest::SHA256.hexdigest(TOKEN)
      )
    end
  end

  def error_response(data, status=400)
    render json: { status: 'error', data: data }, status: status
  end

  def success_response(data=[], opt = {})
    options = { status: 200, text_status: 'success' }.merge(opt)
    render json: { status: options[:text_status], data: data }, status: options[:status]
  end

end