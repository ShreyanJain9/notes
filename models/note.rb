class Note < Sequel::Model
  many_to_one :user
  many_to_many :collaborators, class: :User, join_table: :collaborations, left_key: :note_id, right_key: :collaborator_id
end

# define a similar class for posts
class Chirp < Sequel::Model
  many_to_one :user
end
