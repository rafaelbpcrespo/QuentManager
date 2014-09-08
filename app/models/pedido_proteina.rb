class PedidoProteina < ActiveRecord::Base
  belongs_to :pedido
  belongs_to :proteina

  validates :proteina_id, :quantidade, presence: true
end
