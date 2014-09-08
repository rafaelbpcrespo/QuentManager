class PedidoSobremesa < ActiveRecord::Base
  belongs_to :pedido
  belongs_to :sobremesa

  validates :sobremesa_id, :quantidade, presence: true  
end
