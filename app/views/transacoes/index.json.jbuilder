json.array!(@transacoes) do |transacao|
  json.extract! transacao, :id, :produto_id, :valor, :quantidade, :tipo
  json.url transacao_url(transacao, format: :json)
end
