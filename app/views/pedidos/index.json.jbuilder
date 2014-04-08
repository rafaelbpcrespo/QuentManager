json.array!(@pedidos) do |pedido|
  json.extract! pedido, :id, :descricao, :valor, :client_id, :forma_de_pagamento
  json.url pedido_url(pedido, format: :json)
end
