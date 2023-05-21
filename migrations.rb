require_relative "db"

DB.create_table?(:users) do
  primary_key :id
  String :username, unique: true
  String :password_digest
end

DB.create_table?(:notes) do
  primary_key :id
  String :content
  DateTime :created_at
  foreign_key :user_id, :users
end
