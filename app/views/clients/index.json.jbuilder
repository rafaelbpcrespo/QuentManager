json.array!(@clients) do |client|
  json.extract! client, :id, :nome, :celular, :telefone, :ramal, :endereco, :complemento, :empresa, :sexo, :data_de_nascimento
  json.url client_url(client, format: :json)
end
