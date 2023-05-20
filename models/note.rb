require "sequel"

class Note < Sequel::Model
  many_to_one :user
end
