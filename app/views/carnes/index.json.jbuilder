json.array!(@carnes) do |carne|
  json.extract! carne, :id, :nome, :quantidade, :disponibilidade
  json.url carne_url(carne, format: :json)
end
