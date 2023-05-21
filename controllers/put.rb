put "/notes/:note_id" do
  authorization_header = request.env["HTTP_AUTHORIZATION"]

  if authorization_header && authorization_header.start_with?("Bearer ")
    jwt_token = authorization_header.sub("Bearer ", "")
    payload = JWT.decode(jwt_token, JWT_SECRET, true, algorithm: "HS256").first

    username = payload["username"]
    user = User.find(username: username)

    if user
      note = user.notes_dataset.first(id: params[:note_id])

      if note
        request_body = JSON.parse(request.body.read)
        new_content = request_body["content"]

        note.update(content: new_content)

        { message: "Note updated successfully" }.to_json
      else
        status 404
        { error: "Note not found" }.to_json
      end
    else
      status 401
      { error: "Invalid token" }.to_json
    end
  else
    status 401
    { error: "Missing token" }.to_json
  end
end
