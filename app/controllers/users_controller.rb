class UsersController < ApplicationController

  include UsersHelper

  before_action :check_admin, only: [:index, :destroy]
  before_action :set_user, only: [:show, :update, :destroy]

  # GET /users
  def index
    @users = User.all

    api_success @users
  end

  # GET /users/1
  def show
    me = session_user
    if me._id != @user._id || me.role != 'admin'
      api_auth_fail
    end
    api_success @user
  end

  # POST /users
  def create
    @user = User.new(user_params)
    @user.email_code = new_verification_code
    if @user.save
      api_success(@user, 'user_created', :created)
    else
      api_validation_fail @user.errors
    end
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      api_success @user
    else
      api_validation_fail @user.errors
    end
  end

  # POST /users/delete/1
  def delete
    @user.deleted_at = DateTime.now
    if @user.save
      api_success
    else
      api_validation_fail @user.errors
    end
  end

  # DELETE /users/1
  def destroy
    if @user.destroy
      api_success
    else
      api_validation_fail @user.errors
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.

  def check_admin
    check_auth('admin')
  end

  def set_user
    @user = User.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def user_params
    params.require(:user).permit(:username, :email, :role, :verified, :allowed, :birthday, :password)
  end

end