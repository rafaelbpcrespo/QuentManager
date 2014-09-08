class PedidoSalada < ActiveRecord::Base
  belongs_to :pedido
  belongs_to :salada

  validates :salada_id, :quantidade, presence: true
end
