def require_models(model_list)
  model_list.each do |model|
    require_relative "models/#{model}"
  end
end

# Example usage
model_list = ["note", "user", "post"]
require_models(model_list)
