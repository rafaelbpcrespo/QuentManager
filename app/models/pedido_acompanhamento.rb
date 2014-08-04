class PedidoAcompanhamento < ActiveRecord::Base
  belongs_to :acompanhamento
  belongs_to :pedido
end
