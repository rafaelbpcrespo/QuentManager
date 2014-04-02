json.array!(@orders) do |order|
  json.extract! order, :id, :descricao, :valor, :client_id, :forma_de_pagamento
  json.url order_url(order, format: :json)
end
