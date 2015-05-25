class HomeController < ApplicationController
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery
  before_action :authenticate_usuario!, :except => [:index, :sobre]

  def index
    
  end

  def inicial

  end

  def teste

  end

  def vendas
    if params[:data].blank?
      data = DateTime.now
    else
      data = params[:data].to_datetime
    end

    @acompanhamentos = [] 
    @qtds_acompanhamento = []
    PedidoAcompanhamento.where(created_at: data.beginning_of_day..data.end_of_day).map { |p| @acompanhamentos << p.acompanhamento.nome; @qtds_acompanhamento << p.quantidade }
    @quantidade_acompanhamento = Hash.new 0

    @acompanhamentos.each_with_index do |acompanhamento,i|
      @quantidade_acompanhamento[acompanhamento] += @qtds_acompanhamento[i]
    end

    @proteinas = []
    @qtds_proteina = []
    PedidoProteina.where(created_at: data.beginning_of_day..data.end_of_day).map { |p| @proteinas << p.proteina.nome; @qtds_proteina << p.quantidade  }
    @quantidade_proteina = Hash.new 0

    @proteinas.each_with_index do |proteina,i|
      @quantidade_proteina[proteina] += @qtds_proteina[i]
    end

    @guarnicoes = []
    @qtds_guarnicao = []
    PedidoGuarnicao.where(created_at: data.beginning_of_day..data.end_of_day).map { |p| @guarnicoes << p.guarnicao.nome; @qtds_guarnicao << p.quantidade }
    @quantidade_guarnicao = Hash.new 0

    @guarnicoes.each_with_index do |guarnicao,i|
      @quantidade_guarnicao[guarnicao] += @qtds_guarnicao[i]
    end

    @saladas = []
    @qtds_salada = []
    PedidoSalada.where(created_at: data.beginning_of_day..data.end_of_day).map { |p| @saladas << p.salada.nome; @qtds_salada << p.quantidade  }
    @quantidade_salada= Hash.new 0

    @saladas.each_with_index do |salada,i|
      @quantidade_salada[salada] += @qtds_salada[i]
    end

    @bebidas = []
    @qtds_bebida = []
    PedidoBebida.where(created_at: data.beginning_of_day..data.end_of_day).map { |p| @bebidas << p.bebida.nome; @qtds_bebida << p.quantidade }
    @quantidade_bebida = Hash.new 0

    @bebidas.each_with_index do |bebida,i|
      @quantidade_bebida[bebida] += @qtds_bebida[i]
    end

    @sobremesas = []
    @qtds_sobremesa = []
    PedidoSobremesa.where(created_at: data.beginning_of_day..data.end_of_day).map { |p| @sobremesas << p.sobremesa.nome; @qtds_sobremesa << p.quantidade }
    @quantidade_sobremesa = Hash.new 0

    @sobremesas.each_with_index do |sobremesa,i|
      @quantidade_sobremesa[sobremesa] += @qtds_sobremesa[i]
    end

  end

  def cardapio

  end

  def conta_clientes
    @clientes = Cliente.select('*').joins(:conta).where('saldo < 0').order(:nome => :asc).search(params[:search],params[:empresa])
   #@clientes = Cliente.all.order(:nome => :asc).paginate(:page => params[:page], :per_page => 10).search(params[:search],params[:empresa])
  end

  def relatorio_produtos
    @produtos_acabando = Produto.acabando_completo
    @produtos_em_falta = Produto.zerados
  end

  def pedidos_do_dia
    @pedidos = Pedido.confirmados_do_dia
  end

  def relatorio_pedidos
    @pedidos_confirmados_do_mes = Pedido.confirmados_do_mes
    @pedidos_cancelados_do_mes = Pedido.cancelados_do_mes
    @pedidos_confirmados_do_dia = Pedido.confirmados_do_dia
    @pedidos_cancelados_do_dia = Pedido.cancelados_do_dia
  end

  def pedidos_empresa
    @pedidos = Pedido.confirmados_do_dia.search("",params[:empresa],"")
      if !params[:empresa].blank?
        @nome_da_empresa = Empresa.find(params[:empresa]).nome
      else
        @nome_da_empresa = "Todas as Empresas"
      end    
    #@pedidos = Pedido.confirmados_do_dia    
  end

  def search
    @pedidos = Pedidos.search params[:empresa]
  end

end
