json.array!(@clientes) do |cliente|
  json.extract! cliente, :id, :nome, :celular, :telefone, :ramal, :endereco, :complemento, :empresa, :sexo, :data_de_nascimento
  json.url client_url(cliente, format: :json)
end
