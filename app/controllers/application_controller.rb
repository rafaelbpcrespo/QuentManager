class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery
  alias_method :current_user, :current_usuario

  def index

  end

  rescue_from CanCan::AccessDenied do |exception|
    exception.default_message = "Você não tem permissão para executar esta operação."
    redirect_to root_url, :alert => exception.message
  end
#  @qtd_clientes = Cliente.all.count
end
