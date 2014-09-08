class HomeController < ApplicationController
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery
  before_action :authenticate_usuario!

  def index
    
  end

  def relatorio_produtos
    
  end

  def relatorio_pedidos
    @pedidos_confirmados_do_mes = Pedido.confirmados_do_mes
    @pedidos_cancelados_do_mes = Pedido.cancelados_do_mes
    @pedidos_confirmados_do_dia = Pedido.confirmados_do_dia
    @pedidos_cancelados_do_dia = Pedido.cancelados_do_dia
  end
end
