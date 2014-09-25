class HomeController < ApplicationController
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery
  before_action :authenticate_usuario!, :except => [:index, :sobre]

  def index
    
  end

  def inicial

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
end
