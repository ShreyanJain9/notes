def require_helpers(helper_list)
  helper_list.each do |helper|
    require_relative "helpers/#{helper}"
  end
end

# Example usage
helper_list = []
require_helpers(helper_list)
