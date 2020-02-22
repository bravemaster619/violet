class ApplicationController < ActionController::API

  include AuthHelper

  def check_auth(role = 'user')
    if has_role(role)
      true
    else
      api_auth_fail
    end
  end

  def api_success(data = nil, message = '', status = :ok)
    render json: { success: true, data: data, message: message }, status: status
  end

  def api_fail(data = nil, message = '', status = :internal_server_error)
    render json: { success: false, data: data, message: message }, status: status
  end

  def api_auth_fail(data = nil, message = 'authorization_failed')
    api_fail(data, message, :forbidden)
  end

  def api_validation_fail(data = nil, message = 'validation_failed')
    api_fail(data, message, :unprocessable_entity)
  end

end
