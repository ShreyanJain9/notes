# frozen_string_literal: true

get "/die/roll" do
  content_type :json
  rolled = Die.new.roll
  { :ok => true, message: "Dice rolled successfully", face: rolled }.to_json
end

get "/die/cheat/:facenumber" do
  content_type :json
  Die.new.cheat(params[:facenumber].to_i)
end
