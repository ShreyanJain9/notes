require "bcrypt"

class User < Sequel::Model
  one_to_many :notes, class: :Note
  many_to_many :shared_notes, class: :Note, join_table: :collaborations, left_key: :collaborator_id, right_key: :note_id

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
