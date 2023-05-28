def require_models(model_list)
  model_list.each do |model|
    require_relative "models/#{model}"
  end
end

# Example usage
model_list = %w(note user die)
require_models(model_list)
