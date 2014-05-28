class Cardapio < ActiveRecord::Base
  has_many :pedidos

#  scope :de_hoje, -> { where(created_at: (Time.now.midnight)..Time.now.midnight + 1.day).count }
  scope :carne, -> { where(tipo: "Carne")}

  def verificar_quantidade
    if self.quantidade == 0
      self.disponibilidade = false
      self.save
    end
  end

  def decrescer
    self.quantidade = self.quantidade - 1
    self.save
    self.verificar_quantidade
  end
end
