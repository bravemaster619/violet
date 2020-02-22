require 'jwt'

class AuthController < ApplicationController

  def login
    user = User.find_by(email: params[:email])
    if user
      if user.authenticate(params[:password])
        payload = { user_id: user._id }
        token = encode_token(payload)
        render json: { user: user, jwt: token }
      else
        render json: { success: false, message: 'password_mismatch' }
      end
    else
      render json: { success: false, message: 'no_such_user' }
    end
  end

end
