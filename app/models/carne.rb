class Carne < ActiveRecord::Base
  has_many :pedidos

  def verificar_quantidade
    debugger
    if self.quantidade == 0
      debugger
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
