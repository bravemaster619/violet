# frozen_string_literal: true
require 'jwt'

class AuthController < ApplicationController

  include UsersHelper

  def login
    @user = User.find_by(email: params[:email])
    if @user
      if @user.authenticate(params[:password])
        token = encode_token({ user_id: @user._id })
        api_success(user: filter_user_params, jwt: token)
      else
        api_auth_fail(nil, 'password_mismatch')
      end
    else
      api_auth_fail(nil, 'no_such_user')
    end
  end

  def register
    @user = User.new(user_params)
    @user.email_code = new_verification_code
    @user.role = 'user'
    @user.verified = false
    @user.allowed = true
    if @user.save
      UsersMailer.with(@user).send_verification_code
      api_success(filter_user_params, '', :created)
    else
      api_validation_fail(@user.errors)
    end
  end

  private

  def user_params
    params.permit(:name, :email, :birthday, :password)
  end

  def filter_user_params
    @user.attributes.except("email_code", "allowed", "role")
  end

end
