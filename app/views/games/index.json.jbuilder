json.array!(@games) do |game|
  json.extract! game, :id, :title, :start, :finish
  json.url game_url(game, format: :json)
end
