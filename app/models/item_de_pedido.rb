class ItemDePedido < ActiveRecord::Base
  belongs_to :produto
  belongs_to :pedido

  validates :produto_id, :pedido_id, :quantidade, presence: true
end
