require "sequel"
require "bcrypt"

class User < Sequel::Model
  one_to_many :notes

  def password=(password)
    self.password_digest = BCrypt::Password.create(password)
  end

  def password_valid?(password)
    BCrypt::Password.new(password_digest) == password
  end

  def self.authenticate(username, password)
    user = find(username: username)
    return nil unless user

    user.password_valid?(password) ? user : nil
  end
end
