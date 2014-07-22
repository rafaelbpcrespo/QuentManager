json.array!(@entradas) do |entrada|
  json.extract! entrada, :id, :nome, :descricao, :disponibilidade
  json.url entrada_url(entrada, format: :json)
end
