json.array!(@bebidas) do |bebida|
  json.extract! bebida, :id, :nome, :quantidade, :valor, :disponibilidade, :tipo
  json.url bebida_url(bebida, format: :json)
end
