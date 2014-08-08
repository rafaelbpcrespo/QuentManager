class PedidoAcompanhamento < ActiveRecord::Base
  belongs_to :acompanhamento
  belongs_to :pedido

  validates :acompanhamento_id, :pedido_id, :quantidade, presence: true
end
