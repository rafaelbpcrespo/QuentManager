class Transacao < ActiveRecord::Base
  belongs_to :produto
  before_create :atualizar_quantidade_produto

  def atualizar_quantidade_produto
    if self.tipo == 1
      quantidade = self.quantidade
    elsif self.tipo == 2
      quantidade = (self.quantidade * (-1))
    end 
    self.produto.atualizar(quantidade)
  end

  def tipo_exibicao
    if self.tipo == 1
      return "Entrada"
    elsif self.tipo == 2
      return "Saída"
    end
  end
end
