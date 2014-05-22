class Produto < ActiveRecord::Base
  has_many :item_de_pedidos
  has_many :pedidos, through: :item_de_pedidos

  validates :tipo, :nome, :quantidade, :valor_unitario, presence: true

  scope :bebidas, -> { where(tipo: "Bebida") }

  def atualizar(quantidade)
    self.quantidade = self.quantidade + quantidade
    self.save
  end

  def abaixo_do_limite?
    if  self.quantidade <= self.limite_minimo
      return true
    else
      return false
    end
  end
end
