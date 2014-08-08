class PedidoAcompanhamento < ActiveRecord::Base
  belongs_to :acompanhamento
  belongs_to :pedido

  validates :acompanhamento_id, presence: true
end
