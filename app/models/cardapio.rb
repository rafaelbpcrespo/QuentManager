class Cardapio < ActiveRecord::Base
  has_many :pedidos_cardapios
  has_many :pedidos, through: :pedidos_cardapios
#  scope :de_hoje, -> { where(created_at: (Time.now.midnight)..Time.now.midnight + 1.day).count }
  scope :carne, -> { where(tipo: "Carne")}

  def verificar_quantidade
    if self.quantidade == 0
      self.disponibilidade = false
      self.save
    end
  end

  def decrescer(quantidade_vendida)
    self.quantidade = self.quantidade - quantidade_vendida
    self.save
    self.verificar_quantidade
  end
end
