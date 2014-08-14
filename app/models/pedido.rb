class Pedido < ActiveRecord::Base
  belongs_to :cliente
  has_many :pedidos_acompanhamentos
  has_many :acompanhamentos, through: :pedidos_acompanhamentos
  has_many :item_de_pedidos
  has_many :produtos, through: :item_de_pedidos
  has_many :pedidos_proteinas
  has_many :proteinas, through: :pedidos_proteinas
  has_many :pedidos_guarnicoes
  has_many :guarnicoes, through: :pedidos_guarnicoes
  has_many :pedidos_saladas
  has_many :saladas, through: :pedidos_saladas

  validates :cliente_id, presence: true

  accepts_nested_attributes_for :item_de_pedidos,  :allow_destroy => true

  scope :de_hoje, -> { where(created_at: (Time.now.midnight)..Time.now.midnight + 1.day).count }

  def self.vendidos_hoje
    valor_total = 0
    pedidos = Pedido.where(created_at: (Time.now.midnight)..(Time.now.midnight + 1.day))
    pedidos.each do |pedido|
      valor_total = valor_total + pedido.valor
    end
    valor_total
  end

  def calcular_valor
    valor_pedido = 0
    self.item_de_pedidos.each do |item|
      valor_pedido = valor_pedido + (item.produto.valor_unitario * item.quantidade)
    end
    self.valor = valor_pedido
  end

  def self.vendas_do_mes
    valor = 0;
    Pedido.find(:all, :conditions => ['created_at > ?', Time.now.beginning_of_month]).map { |p| valor = valor + p.valor}
    valor
  end

    def cancelar
      self.cancelado = true
    end

    def cancelar!
      self.cancelar
      self.save!
    end

    def cancelado?
      self[:cancelado]
    end

    def qtd_extras(dados,limite)
      total=0
      dados.each do |dado|
        total = total + dado.quantidade
      end
      total = total - limite
      return total
    end

    def extra(dados,limite)
      if !dados.empty? 
        classe = dados.first.class
        total=0
        dados.each do |dado|
          total = total + dado.quantidade
        end
        if total > limite
          qtd=0
          cont=0
          valor=0
          dados.each do |dado|
            qtd = qtd + dado.quantidade
            if qtd > limite
              if cont == 0
                if classe == PedidoGuarnicao
                  valor = valor + ((qtd-limite)*dado.guarnicao.valor)
                elsif classe == PedidoProteina
                  valor = valor + ((qtd-limite)*dado.proteina.valor)
                elsif classe == PedidoAcompanhamento
                  valor = valor + ((qtd-limite)*dado.acompanhamento.valor)
                end
                cont = 1
              else
                if classe == PedidoGuarnicao
                  valor = valor + (dado.quantidade * dado.guarnicao.valor)
                elsif classe == PedidoProteina
                  valor = valor + (dado.quantidade * dado.proteina.valor)
                elsif classe == PedidoAcompanhamento
                  valor = valor + (dado.quantidade * dado.acompanhamento.valor)
                end
              end
            end
          end
        end
        return valor.to_f
      end
    end

    # def guarnicoes_extra
    #   total_guarnicoes=0
    #   self.pedidos_guarnicoes.each do |guarnicao|
    #     total_guarnicoes = total_guarnicoes + guarnicao.quantidade
    #   end
    #   if total_guarnicoes > 2
    #     qtd=0
    #     cont=0
    #     valor=0
    #     self.pedidos_guarnicoes.each_with_index do |g,i|
    #       qtd = qtd + g.quantidade
    #       if qtd > 2
    #         if cont == 0
    #           valor = valor + ((qtd-2)*g.guarnicao.valor)
    #           cont = 1
    #         else
    #           valor = valor + (g.quantidade * g.guarnicao.valor)
    #         end
    #       end
    #     end
    #   end
    #   return valor
    # end

end