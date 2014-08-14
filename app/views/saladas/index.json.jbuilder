json.array!(@saladas) do |salada|
  json.extract! salada, :id, :nome, :quantidade, :disponibilidade, :valor, :descricao
  json.url salada_url(salada, format: :json)
end
