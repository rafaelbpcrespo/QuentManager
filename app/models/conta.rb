class Conta < ActiveRecord::Base
  belongs_to :cliente
  has_many :pedidos
  has_many :pagamentos

  def calcular_saldo
    total = 0
    self.pedidos.each  do |pedido|
      total = total - pedido.valor
    end

    self.pagamentos.each do |pagamento|
      total = total + pagamento.valor
    end
    self.saldo = total
    self.save
  end
end
