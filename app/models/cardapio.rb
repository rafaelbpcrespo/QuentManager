class Cardapio < ActiveRecord::Base
  has_many :pedidos_cardapios
  has_many :pedidos, through: :pedidos_cardapios
#  scope :de_hoje, -> { where(created_at: (Time.now.midnight)..Time.now.midnight + 1.day).count }
  scope :carne, -> { where(tipo: "Carne")}

  validates :nome, :quantidade, :valor, presence: true

  def verificar_quantidade
    if self.quantidade == 0
      self.disponibilidade = false
      self.save
    else
      self.disponibilidade = true
      self.save
    end
  end

  def acrescer(quantidade_retornada)
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
