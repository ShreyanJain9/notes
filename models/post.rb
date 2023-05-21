# post.rb
class Post < Sequel::Model
  many_to_one :user

  def to_json(options = {})
    {
      id: id,
      content: content,
      created_at: created_at,
      user_id: user_id,
    }
  end
end
