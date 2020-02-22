module AuthHelper

  def session_user
    decoded_hash = decode_token
    if decoded_hash && !decoded_hash.empty?
      user_id = decoded_hash[0]['user_id']
      @user = User.find_by(id: user_id)
    end
    nil
  end

  def auth_header
    request.headers['Authorization']
  end

  def encode_token(payload)
    JWT.encode(payload, ENV['JWT_SECRET_KEY'])
  end

  def decode_token
    if auth_header
      token = auth_header.split(' ')[1]
      begin
        JWT.decode(token, ENV['JWT_SECRET_KEY'])
      rescue JWT::DecodeError
        []
      end
    end
  end

  def has_role(role = 'user')
    me = session_user
    if me.nil?
      false
    else
      case role
      when 'admin'
        me.role == 'admin'
      when 'user'
        me.role == 'user' || me.role == 'admin'
      else
        false
      end
    end
  end

end