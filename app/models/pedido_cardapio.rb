class PedidoCardapio < ActiveRecord::Base
  belongs_to :pedido
  belongs_to :cardapio
end
