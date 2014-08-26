json.array!(@pagamentos) do |pagamento|
  json.extract! pagamento, :id, :conta_id, :valor
  json.url pagamento_url(pagamento, format: :json)
end
