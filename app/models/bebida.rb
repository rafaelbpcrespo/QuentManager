class Bebida < ActiveRecord::Base
  has_many :pedidos_bebidas
  has_many :pedidos, through: :pedidos_bebidas

  before_save :ver_disponibilidade

  validates :nome, :quantidade, :valor, :tipo, presence: true

    def ver_disponibilidade
    if self.quantidade != 0
      self.disponibilidade = true
    else
      self.disponibilidade = false
      true
    end
  end

  def verificar_quantidade
    self.ver_disponibilidade
    self.save
  end

  def acrescer(quantidade_retornada)
    self.quantidade = self.quantidade + quantidade_retornada
    self.save
    self.verificar_quantidade
  end

  def acrescer_pos_cancelamento(quantidade_retornada)
    self.quantidade = self.quantidade + quantidade_retornada
    self.save
    self.verificar_quantidade
  end

  def decrescer(quantidade_vendida)
    self.quantidade = self.quantidade - quantidade_vendida
    self.save
    self.verificar_quantidade
  end
end