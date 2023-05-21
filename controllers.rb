def require_controllers(controller_names_list)
  controller_names_list.each do |controller_name|
    require_relative "controllers/#{controller_name}"
  end
end

controllers = ["delete", "getnotes", "put", "users", "shares", "posts"]
require_controllers(controllers)
