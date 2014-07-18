class Pedido < ActiveRecord::Base
  belongs_to :cliente
  has_many :item_de_pedidos
  has_many :produtos, through: :item_de_pedidos
  belongs_to :cardapio
  belongs_to :arroz
  accepts_nested_attributes_for :item_de_pedidos,  :allow_destroy => true

  scope :de_hoje, -> { where(created_at: (Time.now.midnight)..Time.now.midnight + 1.day).count }

  def self.vendidos_hoje
    valor_total = 0
    pedidos = Pedido.where(created_at: (Time.now.midnight)..(Time.now.midnight + 1.day))
    pedidos.each do |pedido|
      valor_total = valor_total + pedido.valor
    end
    valor_total
  end

  def calcular_valor
    valor_pedido = 0
    self.item_de_pedidos.each do |item|
      valor_pedido = valor_pedido + (item.produto.valor_unitario * item.quantidade)
    end
    self.valor = valor_pedido
  end
end
