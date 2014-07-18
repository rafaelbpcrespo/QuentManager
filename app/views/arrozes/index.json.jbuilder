json.array!(@arrozes) do |arroz|
  json.extract! arroz, :id, :nome, :disponibilidade
  json.url arroz_url(arroz, format: :json)
end
