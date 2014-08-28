json.array!(@sobremesas) do |sobremesa|
  json.extract! sobremesa, :id, :nome, :quantidade, :valor, :disponibilidade, :descricao
  json.url sobremesa_url(sobremesa, format: :json)
end
