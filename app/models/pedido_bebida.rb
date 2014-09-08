class PedidoBebida < ActiveRecord::Base
  belongs_to :pedido
  belongs_to :bebida

  validates :bebida_id, :quantidade, presence: true
end
