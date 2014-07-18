json.array!(@guarnicoes) do |guarnicao|
  json.extract! guarnicao, :id, :nome, :disponibilidade
  json.url guarnicao_url(guarnicao, format: :json)
end
