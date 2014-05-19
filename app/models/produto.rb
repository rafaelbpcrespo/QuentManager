class Produto < ActiveRecord::Base
  has_many :item_de_pedidos
  has_many :pedidos, through: :item_de_pedidos

  validates :tipo, :nome, :quantidade, :valor_unitario, presence: true
end
