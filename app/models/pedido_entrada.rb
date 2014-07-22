class PedidoEntrada < ActiveRecord::Base
  belongs_to :entrada
  belongs_to :pedido
end
