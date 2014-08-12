json.array!(@guarnicoes) do |guarnicao|
  json.extract! guarnicao, :id, :nome, :quantidade, :disponibilidade, :valor, :descricao
  json.url guarnicao_url(guarnicao, format: :json)
end
