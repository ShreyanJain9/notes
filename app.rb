require "sinatra"
require "sinatra/json"
require "sinatra/base"
require "sinatra/contrib"
require "sinatra/reloader"
require "jwt"
require_relative "db"
require_relative "controllers"
require_relative "helpers"

register Sinatra::Namespace
session_secret = SecureRandom.hex(32)

configure do
  enable :sessions
  set :session_secret, session_secret
  set :views, File.join(__dir__, "views")
  set :public_folder, File.join(__dir__, "public")
  # set :erb, layout: :layout
end

JWT_SECRET = Math::PI.to_s

# before do
#   content_type :json
# end

set :public_folder, Proc.new { File.join(root, "frontend") }

get "/" do
  erb :home
end

get "/home/register" do
  erb :register
end

get "/styles.css" do
  content_type "text/css"
  File.read(File.join("public", "styles.css"))
end
