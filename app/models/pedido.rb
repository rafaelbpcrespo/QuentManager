class Pedido < ActiveRecord::Base
  belongs_to :cliente
  has_many :pedidos_entradas
  has_many :entradas, through: :pedidos_entradas
  has_many :item_de_pedidos
  has_many :produtos, through: :item_de_pedidos
  belongs_to :cardapio
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

  def self.vendas_do_mes
    valor = 0;
    Pedido.find(:all, :conditions => ['created_at > ?', Time.now.beginning_of_month]).map { |p| valor = valor + p.valor}
    valor
  end

end
