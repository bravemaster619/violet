class User

  include Mongoid::Document
  include Mongoid::Timestamps
  include ActiveModel::SecurePassword

  has_secure_password

  field :name, type: String
  field :email, type: String
  field :role, type: String
  field :birthday, type: Date
  field :oauth, type: Hash
  field :password_digest, type: String
  field :email_code, type: String
  field :verified, type: Boolean
  field :allowed, type: Boolean
  field :deleted_at, type: Date

end