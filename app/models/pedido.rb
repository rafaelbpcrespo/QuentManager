class Pedido < ActiveRecord::Base
  belongs_to :cliente
  has_many :item_de_pedidos
  has_many :produtos, through: :item_de_pedidos
  accepts_nested_attributes_for :item_de_pedidos
end
