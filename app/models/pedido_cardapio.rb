class PedidoCardapio < ActiveRecord::Base
  belongs_to :pedido
  belongs_to :cardapio

  validates :cardapio_id, :quantidade, presence: true
end
