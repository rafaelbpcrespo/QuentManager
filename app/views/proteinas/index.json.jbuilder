json.array!(@cardapios) do |cardapio|
  json.extract! cardapio, :id, :nome, :quantidade, :disponibilidade
  json.url cardapio_url(cardapio, format: :json)
end
