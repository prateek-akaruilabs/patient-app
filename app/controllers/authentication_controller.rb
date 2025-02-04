class AuthenticationController < ApplicationController
    skip_before_action :authenticate
 
    def login
      user = User.find_by(email: params[:email])
      authenticated_user = user&.authenticate(params[:password])
   
      if authenticated_user
        session[:user_id] = user.id
        # token = JsonWebToken.encode(user_id: user.id)
        # expires_at = JsonWebToken.decode(token)[:exp]
        flash[:success] = 'Congratulations! you are login successfully.'
        redirect_to patients_path
      else
        flash[:danger] = "Please check the login details."
        redirect_to root_path
      end
    end

    def logout
      session[:user_id] = nil
      flash[:success] = 'Congratulations! you are logged out successfully.'
      redirect_to root_path
    end
end