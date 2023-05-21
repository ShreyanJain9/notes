post "/posts" do
  content_type :json
  user = authenticate!

  post = Post.create(content: params[:content], user_id: user.id)
  if post
    status 201
    post.to_json
  else
    status 400
    { error: "Failed to create post" }.to_json
  end
end

# Get a specific post
get "/posts/:id" do |id|
  content_type :json

  post = Post[id]
  if post
    post.to_json
  else
    status 404
    { error: "Post not found" }.to_json
  end
end

# Get all posts
get "/posts" do
  content_type :json

  posts = Post.all
  posts.to_json
end

# Update a post
put "/posts/:id" do |id|
  content_type :json
  user = authenticate!

  post = Post[id]
  if post && post.user_id == user.id
    post.update(content: params[:content])
    post.to_json
  else
    status 404
    { error: "Post not found" }.to_json
  end
end

# Delete a post
delete "/posts/:id" do |id|
  content_type :json
  user = authenticate!

  post = Post[id]
  if post && post.user_id == user.id
    post.destroy
    status 204
  else
    status 404
    { error: "Post not found" }.to_json
  end
end
