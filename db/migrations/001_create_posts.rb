# 001_create_posts.rb
Sequel.migration do
  change do
    create_table?(:posts) do
      primary_key :id
      String :content, null: false
      DateTime :created_at, null: false, default: Sequel::CURRENT_TIMESTAMP
      foreign_key :user_id, :users
    end
  end
end
