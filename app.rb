require "sinatra"
require "sinatra/json"
require "sinatra/base"
require "jwt"
require "sinatra/contrib"
require_relative "db"
require "sinatra/reloader"
require_relative "controllers"
require_relative "models"

register Sinatra::Namespace
session_secret = SecureRandom.hex(32)

configure do
  enable :sessions
  set :session_secret, session_secret
  set :views, File.join(__dir__, "views")
  set :public_folder, File.join(__dir__, "public")
  # set :erb, layout: :layout
end

JWT_SECRET = SecureRandom.hex(32)

# before do
#   content_type :json
# end

set :public_folder, Proc.new { File.join(root, "frontend") }

get "/" do
  erb :home
end
