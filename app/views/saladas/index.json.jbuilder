json.array!(@saladas) do |salada|
  json.extract! salada, :id, :nome, :disponibilidade
  json.url salada_url(salada, format: :json)
end
