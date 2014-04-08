json.array!(@products) do |product|
  json.extract! product, :id, :nome, :valor_unitario
  json.url product_url(product, format: :json)
end
