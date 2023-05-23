require "sequel"

DB = Sequel.sqlite("pastebin.db")

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

# migration for public posts (chirps)
DB.create_table?(:chirps) do
  primary_key :id
  String :content
  DateTime :created_at
  foreign_key :user_id, :users
end


DB.create_table?(:collaborations) do
  primary_key :id
  foreign_key :note_id, :notes
  foreign_key :user_id, :users
end
