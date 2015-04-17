class HomeController < ApplicationController
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery
  before_action :authenticate_usuario!, :except => [:index, :sobre]

  def index
    
  end

  def inicial

  end

  def cardapio

  end

  def conta_clientes
    @clientes = Cliente.select('*').joins(:conta).where('saldo < 0').order(:nome => :asc).paginate(:page => params[:page], :per_page => 10).search(params[:search],params[:empresa])
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
    @pedidos = Pedido.confirmados_do_dia.search("",params[:empresa])
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
