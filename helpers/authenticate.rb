def authenticate!
  authorization_header = request.env["HTTP_AUTHORIZATION"]

  if authorization_header && authorization_header.start_with?("Bearer ")
    jwt_token = authorization_header.sub("Bearer ", "")
    payload = JWT.decode(jwt_token, JWT_SECRET, true, algorithm: "HS256").first

    username = payload["username"]
    user = User.find(username: username)
  end
  return user
end
