json.array!(@empresas) do |empresa|
  json.extract! empresa, :id, :nome, :telefone, :endereco
  json.url empresa_url(empresa, format: :json)
end
