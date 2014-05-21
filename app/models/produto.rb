class Produto < ActiveRecord::Base
  has_many :item_de_pedidos
  has_many :pedidos, through: :item_de_pedidos

  validates :tipo, :nome, :quantidade, :valor_unitario, presence: true

  def atualizar(quantidade)
    debugger
    quantidade = quantidade.to_i
    self.quantidade = self.quantidade + quantidade
    self.save
  end
end
