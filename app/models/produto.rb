class Produto < ActiveRecord::Base
  has_many :item_de_pedidos
  has_many :pedidos, through: :item_de_pedidos

  validates :tipo, :nome, :quantidade, :valor_unitario, presence: true

  scope :bebidas, -> { where(categoria: "Bebida") }

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

  def exibicao_select
    "#{self.nome} #{self.tipo}"
  end

  # def fix_rate 
  #   self[:valor_unitario = valor_unitario_before_type_cast. tr(' $, ' , ' ' )
  # end
end
