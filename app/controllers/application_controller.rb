class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  before_action :authenticate

  include ApplicationHelper
  include ActionController::Cookies

  rescue_from JWT::VerificationError, with: :invalid_token
  rescue_from JWT::DecodeError, with: :decode_error

  private

  def authenticate
    # p request.headers['Authorization']
    # authorization_header = request.headers['Authorization']
    # token = authorization_header.split(" ").last if authorization_header
    # decoded_token = JsonWebToken.decode(token)
    # user_id = JsonWebToken.decode(token)[:user_id]
    # expires_at = JsonWebToken.decode(token)[:exp]
  
    @user = User.find_by(id: session[:user_id])
    if @user.blank?
      flash[:alert] = 'Unauthorized request'
      redirect_to root_path
    else
      current_user
    end
  end
  
  def invalid_token
    render json: { invalid_token: 'invalid token' }
  end
  
  def decode_error
    render json: { decode_error: 'decode error' }
  end
end
