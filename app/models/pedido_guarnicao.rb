class PedidoGuarnicao < ActiveRecord::Base
  belongs_to :pedido
  belongs_to :guarnicao

  validates :guarnicao_id, :quantidade, presence: true
end
