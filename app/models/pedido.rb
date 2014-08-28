class Pedido < ActiveRecord::Base
  belongs_to :cliente
  belongs_to :conta
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
  has_many :pedidos_bebidas
  has_many :bebidas, through: :pedidos_bebidas
  has_many :pedidos_sobremesas
  has_many :sobremesas, through: :pedidos_sobremesas

  validates :cliente_id, presence: true

  accepts_nested_attributes_for :item_de_pedidos,  :allow_destroy => true

  scope :de_hoje, -> { where(created_at: (Time.now.midnight)..Time.now.midnight + 1.day).count }
  before_save :atualizar_conta


  LIMITE_GUARNICOES = 2
  LIMITE_PROTEINAS = 1
  LIMITE_SALADAS = 1
  LIMITE_BEBIDAS = 0
  LIMITE_SOBREMESAS = 0

  def self.vendidos_hoje
    valor_total = 0
    pedidos = Pedido.where(created_at: (Time.now.midnight)..(Time.now.midnight + 1.day))
    pedidos.each do |pedido|
      valor_total = valor_total + pedido.valor
    end
    valor_total
  end

  def calcular_valor
    valor_minimo = 10
    valor_produtos = 0
    valor_guarnicoes = 0
    valor_proteinas = 0
    valor_saladas = 0
    valor_bebidas = 0
    valor_sobremesas = 0

    # self.item_de_pedidos.each do |item|
    #   valor_produtos = valor_produtos + (item.produto.valor_unitario * item.quantidade)
    # end
    if self.qtd_extra(self.pedidos_guarnicoes,LIMITE_GUARNICOES) != 0
      valor_guarnicoes = self.extra(self.pedidos_guarnicoes,LIMITE_GUARNICOES)
    end
    if self.qtd_extra(self.pedidos_proteinas,LIMITE_PROTEINAS) != 0
      valor_proteinas = self.extra(self.pedidos_proteinas,LIMITE_PROTEINAS)
    end
    if self.qtd_extra(self.pedidos_saladas,LIMITE_SALADAS) != 0
      valor_saladas = self.extra(self.pedidos_saladas,LIMITE_SALADAS)
    end
    if self.qtd_extra(self.pedidos_bebidas,LIMITE_BEBIDAS) != 0
      valor_bebidas = self.extra(self.pedidos_bebidas,LIMITE_BEBIDAS)
    end
    if self.qtd_extra(self.pedidos_sobremesas,LIMITE_SOBREMESAS) != 0
      valor_sobremesas = self.extra(self.pedidos_sobremesas,LIMITE_SOBREMESAS)
    end
    self.valor = valor_minimo + valor_saladas + valor_proteinas + valor_guarnicoes + valor_bebidas + valor_sobremesas
    self.save!
  end

  # def adicionar_pedido_conta
  #   self.cliente.conta.pedidos << self
  # end

  def self.vendas_do_mes
    valor = 0;
    Pedido.find(:all, :conditions => ['created_at > ?', Time.now.beginning_of_month]).map { |p| valor = valor + p.valor}
    valor
  end

    def cancelar
      self.situacao = "Cancelado"
    end

    def cancelar!
      self.cancelar
      self.pedidos_proteinas.each do |pedido_proteina|
        proteina = pedido_proteina.proteina
        proteina.acrescer(pedido_proteina.quantidade)
      end
      self.pedidos_guarnicoes.each do |pedido_guarnicao|
        guarnicao = pedido_guarnicao.guarnicao
        guarnicao.acrescer(pedido_guarnicao.quantidade)
      end
      self.pedidos_saladas.each do |pedido_salada|
        salada = pedido_salada.salada
        salada.acrescer(pedido_salada.quantidade)
      end      
      self.pedidos_bebidas.each do |pedido_bebida|
        bebida = pedido_bebida.bebida
        bebida.acrescer(pedido_bebida.quantidade)
      end
      self.pedidos_sobremesas.each do |pedido_sobremesa|
        sobremesa = pedido_sobremesa.sobremesa
        sobremesa.acrescer(pedido_sobremesa.quantidade)
      end
      self.save!
    end

    def confirmar
      self.situacao = "Confirmado"
    end

    def confirmar!
      self.pedidos_proteinas.each do |pedido_proteina|
        proteina = pedido_proteina.proteina
        if proteina.quantidade < pedido_proteina.quantidade
          return 0
        else
        proteina.decrescer(pedido_proteina.quantidade)
      end
      end
      self.pedidos_guarnicoes.each do |pedido_guarnicao|
        guarnicao = pedido_guarnicao.guarnicao
        if guarnicao.quantidade < pedido_guarnicao.quantidade
          return 0
        else
          guarnicao.decrescer(pedido_guarnicao.quantidade)
        end        
      end
      self.pedidos_saladas.each do |pedido_salada|
        salada = pedido_salada.salada
        if salada.quantidade < pedido_salada.quantidade
          return 0
        else
          salada.decrescer(pedido_salada.quantidade)
        end        
      end
      self.pedidos_bebidas.each do |pedido_bebida|
        bebida = pedido_bebida.bebida
        if bebida.quantidade < pedido_bebida.quantidade
          return 0
        else
          bebida.decrescer(pedido_bebida.quantidade)
        end
      end
      self.pedidos_sobremesas.each do |pedido_sobremesa|
        sobremesa = pedido_sobremesa.sobremesa
        if sobremesa.quantidade < pedido_sobremesa.quantidade
          return 0
        else
          sobremesa.decrescer(pedido_sobremesa.quantidade)
        end
      end
      self.confirmar
      self.save!      
    end


    def qtd_extra(dados,limite)
      total=0
      dados.each do |dado|
        total = total + dado.quantidade
      end
      total = total - limite
      if total >0
        return total
      else
        return 0
      end
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
                elsif classe == PedidoSalada
                  valor = valor + ((qtd-limite)*dado.salada.valor)
                elsif classe == PedidoBebida
                  valor = valor + ((qtd-limite)*dado.bebida.valor)
                elsif classe == PedidoSobremesa
                  valor = valor + ((qtd-limite)*dado.sobremesa.valor)
                end
                cont = 1
              else
                if classe == PedidoGuarnicao
                  valor = valor + (dado.quantidade * dado.guarnicao.valor)
                elsif classe == PedidoProteina
                  valor = valor + (dado.quantidade * dado.proteina.valor)
                elsif classe == PedidoAcompanhamento
                  valor = valor + (dado.quantidade * dado.acompanhamento.valor)
                elsif classe == PedidoSalada
                  valor = valor + (dado.quantidade * dado.salada.valor)
                elsif classe == PedidoBebida
                  valor = valor + (dado.quantidade * dado.bebida.valor)
                elsif classe == PedidoSobremesa
                  valor = valor + (dado.quantidade * dado.sobremesa.valor)
                end
              end
            end
          end
        end
        return valor.to_f
      end
    end

    def atualizar_conta
      self.conta.calcular_saldo
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