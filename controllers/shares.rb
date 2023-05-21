post "/notes/:note_id/share" do
  authorization_header = request.env["HTTP_AUTHORIZATION"]

  if authorization_header && authorization_header.start_with?("Bearer ")
    jwt_token = authorization_header.sub("Bearer ", "")
    payload = JWT.decode(jwt_token, JWT_SECRET, true, algorithm: "HS256").first

    username = payload["username"]
    user = User.find(username: username)
  end

  content_type :json

  note = Note[params[:note_id]]
  recipient = User.first(username: params[:username])

  unless note && recipient
    halt 404, { message: "Note or user not found" }.to_json
  end

  unless note.user_id == user.id
    halt 403, { message: "You are not the owner of this note" }.to_json
  end

  note.collaborators << recipient

  { message: "Note shared successfully" }.to_json
end

# Retrieve shared notes for the current user
get "/shared" do
  content_type :json
  authorization_header = request.env["HTTP_AUTHORIZATION"]

  if authorization_header && authorization_header.start_with?("Bearer ")
    jwt_token = authorization_header.sub("Bearer ", "")
    payload = JWT.decode(jwt_token, JWT_SECRET, true, algorithm: "HS256").first

    username = payload["username"]
    user = User.find(username: username)
  end

  shared_notes = user.collaborations.map(&:note)

  { notes: shared_notes }.to_json
end
