require "sinatra"
require "sinatra/json"
require "sinatra/base"
require "sinatra/contrib"
require "sinatra/reloader"
require "haml"
require "jwt"
require "sassc"
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
  set :haml, format: :html5
end

JWT_SECRET = Math::PI.to_s

get "/" do
  haml :index
end

get "/home/register" do
  haml :register
end

get "/styles.css" do
  content_type "text/css"
  haml :styles
end

get "/die" do
  haml :dice
end